import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

enum QuizAccessResult { granted, loginRequired, paymentRequired, free }

class QuizPaymentGateScreen extends ConsumerStatefulWidget {
  final String categoryId;
  final String categoryName;
  final int pricePoisha;

  const QuizPaymentGateScreen({
    super.key,
    required this.categoryId,
    required this.categoryName,
    required this.pricePoisha,
  });

  @override
  ConsumerState<QuizPaymentGateScreen> createState() => _QuizPaymentGateScreenState();
}

class _QuizPaymentGateScreenState extends ConsumerState<QuizPaymentGateScreen> {
  bool _isLoading = false;
  String? _errorMessage;
  String _selectedGateway = 'bdapps_dcb';
  String _phone = '';
  String _operator = '';

  @override
  void initState() {
    super.initState();
    _loadUserPhone();
  }

  Future<void> _loadUserPhone() async {
    final user = ref.read(authNotifierProvider).valueOrNull;
    if (user != null) {
      setState(() {
        _phone = user.phone ?? '';
      });
      if (_phone.isNotEmpty) {
        _detectOperator(_phone);
      }
    }
  }

  void _detectOperator(String phone) {
    if (phone.startsWith('018')) {
      setState(() => _operator = 'robi');
    } else if (phone.startsWith('016')) {
      setState(() => _operator = 'airtel');
    } else if (phone.startsWith('017')) {
      setState(() => _operator = 'grameenphone');
    } else if (phone.startsWith('019') || phone.startsWith('014')) {
      setState(() => _operator = 'banglalink');
    } else if (phone.startsWith('013')) {
      setState(() => _operator = 'grameenphone');
    } else {
      setState(() => _operator = 'unknown');
    }
  }

  bool get _isDcbEligible => _operator == 'robi' || _operator == 'airtel';

  Future<void> _handlePayment() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dio = ref.read(dioClientProvider).dio;

      final res = await dio.post(
        '${ApiEndpoints.baseUrl}/api/v1/quiz/${widget.categoryId}/pay',
        data: {
          'gateway': _selectedGateway,
          'phone': _phone,
        },
      );

      final data = res.data;

      if (data['success'] == true) {
        if (_selectedGateway == 'bdapps_dcb') {
          context.push('/quiz/dcb-payment/${widget.categoryId}', extra: {
            'transactionId': data['transaction_id'],
            'phone': data['phone'] ?? _phone,
            'operator': data['operator'] ?? _operator,
            'categoryName': widget.categoryName,
          });
        } else {
          final redirectUrl = data['redirect_url'];
          if (redirectUrl != null && redirectUrl.isNotEmpty) {
            context.push('/quiz/gateway-redirect/${widget.categoryId}', extra: {
              'redirectUrl': redirectUrl,
              'transactionId': data['transaction_id'],
              'categoryName': widget.categoryName,
            });
          }
        }
      } else {
        setState(() {
          _errorMessage = data['message'] ?? 'পেমেন্ট শুরু করা যায়নি';
        });
      }
    } catch (e) {
      String message = 'পেমেন্ট শুরু করা যায়নি';
      if (e is DioException) {
        final response = e.response?.data;
        if (response != null && response is Map) {
          message = response['message'] ?? message;
          if (response['fallback_required'] == true) {
            setState(() => _selectedGateway = 'bkash');
          }
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
      appBar: AppBar(
        title: const Text('কুইজে প্রবেশ করুন'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.quiz, size: 64, color: AppTheme.primary),
              const SizedBox(height: 16),
              Text(
                widget.categoryName,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.amber.shade200),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.lock, size: 32, color: Colors.amber),
                    const SizedBox(height: 8),
                    Text(
                      'এই কুইজটি পেইড',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber.shade800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'মূল্য: ৳${(widget.pricePoisha / 100).toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              const Text('পেমেন্ট মাধ্যম নির্বাচন করুন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              if (_phone.isNotEmpty) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone_android, color: Colors.blue),
                      const SizedBox(width: 8),
                      Text('আপনার নম্বর: $_phone'),
                      const Spacer(),
                      if (_operator.isNotEmpty)
                        Chip(
                          label: Text(_operator.toUpperCase(), style: const TextStyle(fontSize: 11)),
                          backgroundColor: _isDcbEligible ? Colors.green.shade100 : Colors.grey.shade200,
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              if (_isDcbEligible || _phone.isEmpty) _buildGatewayOption('bdapps_dcb', 'মোবাইল বিল (রবি/এয়ারটেল)', 'সরাসরি মোবাইল ব্যালেন্স থেকে কাট হবে', Icons.phone_android),
              _buildGatewayOption('bkash', 'bKash', 'bKash ওয়ালেট দিয়ে পেমেন্ট', Icons.account_balance_wallet),
              _buildGatewayOption('nagad', 'Nagad', 'Nagad ওয়ালেট দিয়ে পেমেন্ট', Icons.account_balance_wallet),
              const SizedBox(height: 24),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(8)),
                    child: Text(_errorMessage!, style: TextStyle(color: Colors.red.shade700)),
                  ),
                ),
              ElevatedButton(
                onPressed: _isLoading ? null : _handlePayment,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isLoading
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Text('পেমেন্ট করুন - ৳${(widget.pricePoisha / 100).toStringAsFixed(0)}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.pop(),
                child: const Text('পিছনে যান'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGatewayOption(String value, String title, String subtitle, IconData icon) {
    final isSelected = _selectedGateway == value;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? AppTheme.primary : Colors.grey.shade300, width: isSelected ? 2 : 1),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppTheme.primary.withOpacity(0.05) : Colors.white,
      ),
      child: RadioListTile<String>(
        value: value,
        groupValue: _selectedGateway,
        onChanged: (v) => setState(() => _selectedGateway = v!),
        title: Row(
          children: [
            Icon(icon, color: isSelected ? AppTheme.primary : Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: isSelected ? AppTheme.primary : Colors.black87)),
                  Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
