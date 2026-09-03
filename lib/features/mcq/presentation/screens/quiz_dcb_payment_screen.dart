import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class QuizDcbPaymentScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String transactionId;
  final String phone;
  final String operator;
  final String categoryName;

  const QuizDcbPaymentScreen({
    super.key,
    required this.categoryId,
    required this.transactionId,
    required this.phone,
    required this.operator,
    required this.categoryName,
  });

  @override
  ConsumerState<QuizDcbPaymentScreen> createState() => _QuizDcbPaymentScreenState();
}

class _QuizDcbPaymentScreenState extends ConsumerState<QuizDcbPaymentScreen> {
  final List<TextEditingController> _otpControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isLoading = false;
  bool _otpSent = false;
  String? _errorMessage;
  int _timerSeconds = 60;
  Future<void>? _timer;

  @override
  void initState() {
    super.initState();
    _sendOtp();
    _startTimer();
  }

  @override
  void dispose() {
    for (var c in _otpControllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _startTimer() {
    setState(() => _timerSeconds = 60);
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _timerSeconds > 0) {
        setState(() => _timerSeconds--);
        _startTimer();
      }
    });
  }

  Future<void> _sendOtp() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dio = ref.read(dioClientProvider).dio;
      await dio.post(
        '${ApiEndpoints.baseUrl}/api/v1/carrier-billing/otp/request',
        data: {'phone': widget.phone},
      );
      setState(() => _otpSent = true);
    } catch (e) {
      setState(() => _errorMessage = 'ওটিপি পাঠাতে ব্যর্থ হয়েছে। আবার চেষ্টা করুন।');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _verifyPayment() async {
    final otp = _otpControllers.map((c) => c.text.trim()).join();
    if (otp.length != 6) {
      setState(() => _errorMessage = 'সম্পূর্ণ ৬ সংখ্যার ওটিপি কোড লিখুন');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final dio = ref.read(dioClientProvider).dio;
      final res = await dio.post(
        '${ApiEndpoints.baseUrl}/api/v1/quiz/${widget.categoryId}/pay/verify-dcb',
        data: {
          'transaction_id': widget.transactionId,
          'phone': widget.phone,
          'otp': otp,
        },
      );

      if (res.data['success'] == true) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(res.data['message'] ?? 'পেমেন্ট সফল হয়েছে!')),
          );
          context.go('/exam/${widget.categoryId}');
        }
      } else {
        setState(() => _errorMessage = res.data['message'] ?? 'যাচাই ব্যর্থ হয়েছে');
      }
    } catch (e) {
      String message = 'যাচাই ব্যর্থ হয়েছে';
      if (e is DioException) {
        final response = e.response?.data;
        if (response != null && response is Map) {
          message = response['message'] ?? message;
        }
      }
      setState(() => _errorMessage = message);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('পেমেন্ট যাচাই'), centerTitle: true),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.lock_open, size: 56, color: AppTheme.primary),
              const SizedBox(height: 12),
              Text(widget.categoryName, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(8)),
                child: Text(
                  '${widget.phone} নম্বরে ওটিপি পাঠানো হয়েছে (${widget.operator.toUpperCase()})',
                  style: const TextStyle(fontSize: 13, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 24),
              const Text('ওটিপি কোড দিন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(6, (index) {
                  return SizedBox(
                    width: 42,
                    height: 52,
                    child: TextField(
                      controller: _otpControllers[index],
                      focusNode: _focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(counterText: '', border: OutlineInputBorder()),
                      onChanged: (val) {
                        if (val.isNotEmpty && index < 5) {
                          _focusNodes[index + 1].requestFocus();
                        } else if (val.isEmpty && index > 0) {
                          _focusNodes[index - 1].requestFocus();
                        }
                      },
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('মেয়াদ: 00:${_timerSeconds.toString().padLeft(2, '0')}', style: const TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                  TextButton(
                    onPressed: _timerSeconds == 0 ? _sendOtp : null,
                    child: const Text('পুনরায় কোড পাঠান', style: TextStyle(fontSize: 12)),
                  ),
                ],
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center),
                ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isLoading ? null : _verifyPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('যাচাই ও কুইজ শুরু করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
