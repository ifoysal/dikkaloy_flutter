import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

enum DcbFlowStep { selectingGateway, enteringPhone, operatorUnsupported, verifyingOtp, subscribedSuccess }

class BillingGateway {
  final String code;
  final String name;
  final String type;
  final String description;
  final bool requiresPhone;
  final List<String> operators;

  BillingGateway({
    required this.code,
    required this.name,
    required this.type,
    required this.description,
    this.requiresPhone = false,
    this.operators = const [],
  });

  factory BillingGateway.fromJson(Map<String, dynamic> json) {
    return BillingGateway(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      description: json['description'] ?? '',
      requiresPhone: json['requires_phone'] ?? false,
      operators: List<String>.from(json['operators'] ?? []),
    );
  }

  String get typeLabel {
    switch (type) {
      case 'carrier_billing':
        return 'মোবাইল বিল';
      case 'digital_wallet':
        return 'ডিজিটাল ওয়ালেট';
      case 'payment_gateway':
        return 'পেমেন্ট গেটওয়ে';
      default:
        return type;
    }
  }

  IconData get typeIcon {
    switch (type) {
      case 'carrier_billing':
        return Icons.phone_android;
      case 'digital_wallet':
        return Icons.account_balance_wallet;
      case 'payment_gateway':
        return Icons.credit_card;
      default:
        return Icons.payment;
    }
  }
}

class CarrierBillingScreen extends ConsumerStatefulWidget {
  const CarrierBillingScreen({super.key});

  @override
  ConsumerState<CarrierBillingScreen> createState() => _CarrierBillingScreenState();
}

class _CarrierBillingScreenState extends ConsumerState<CarrierBillingScreen> {
  final _phoneController = TextEditingController();
  final List<TextEditingController> _otpDigitControllers = List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _otpFocusNodes = List.generate(6, (_) => FocusNode());

  DcbFlowStep _currentStep = DcbFlowStep.selectingGateway;
  bool _isLoading = false;
  String? _errorMessage;
  String _unsupportedOperatorName = '';

  List<BillingGateway> _gateways = [];
  String _selectedGateway = '';
  String _defaultGateway = '';

  Timer? _timer;
  int _timerSeconds = 60;

  @override
  void initState() {
    super.initState();
    _loadGateways();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _phoneController.dispose();
    for (var c in _otpDigitControllers) {
      c.dispose();
    }
    for (var f in _otpFocusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Future<void> _loadGateways() async {
    try {
      final dio = ref.read(dioClientProvider).dio;
      final res = await dio.get(ApiEndpoints.billingGateways);
      if (res.data['success'] == true) {
        final gatewaysData = res.data['available_gateways'] as Map<String, dynamic>;
        final gateways = gatewaysData.values.map((g) => BillingGateway.fromJson(g)).toList();
        setState(() {
          _gateways = gateways;
          _defaultGateway = res.data['default_gateway'] ?? '';
          _selectedGateway = _defaultGateway;
        });
      }
    } catch (e) {
      setState(() {
        _gateways = [];
      });
    }
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _timerSeconds = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_timerSeconds > 0) {
        setState(() => _timerSeconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> _handlePhoneSubmit() async {
    final rawPhone = _phoneController.text.trim();
    if (rawPhone.length < 11) {
      setState(() => _errorMessage = 'সঠিক ১১ ডিজিটের মোবাইল নম্বর দিন (যেমন: 018XXXXXXXX)');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final dio = ref.read(dioClientProvider).dio;

    try {
      final checkRes = await dio.post(ApiEndpoints.dcbOperatorCheck, data: {'phone': rawPhone});
      final checkData = checkRes.data;

      if (checkData['eligible'] != true) {
        setState(() {
          _currentStep = DcbFlowStep.operatorUnsupported;
          _unsupportedOperatorName = checkData['operator_label'] ?? 'অন্যান্য';
          _isLoading = false;
        });
        return;
      }

      final otpRes = await dio.post(ApiEndpoints.carrierBillingOtpRequest, data: {'phone': rawPhone});
      if (otpRes.data['success'] == true) {
        setState(() {
          _currentStep = DcbFlowStep.verifyingOtp;
          _isLoading = false;
        });
        _startTimer();
      } else {
        setState(() {
          _errorMessage = otpRes.data['message'] ?? 'কোড পাঠাতে ব্যর্থ হয়েছে';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'অপারেটর যাচাইয়ে সমস্যা হয়েছে। নম্বরটি রবি বা এয়ারটেল কিনা পরীক্ষা করুন।';
        _isLoading = false;
      });
    }
  }

  Future<void> _handleVerifyAndSubscribe() async {
    final otp = _otpDigitControllers.map((c) => c.text.trim()).join();
    if (otp.length != 6) {
      setState(() => _errorMessage = 'সম্পূর্ণ ৬ সংখ্যার ওটিপি কোড লিখুন');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    final dio = ref.read(dioClientProvider).dio;

    try {
      final res = await dio.post(ApiEndpoints.carrierBillingOtpVerify, data: {
        'phone': _phoneController.text.trim(),
        'otp': otp,
        'product': 'dikkhaloy',
        'gateway': _selectedGateway,
      });

      if (res.data['success'] == true) {
        setState(() {
          _currentStep = DcbFlowStep.subscribedSuccess;
          _isLoading = false;
        });
        Future.delayed(const Duration(seconds: 2), () {
          if (mounted) context.go('/');
        });
      } else {
        setState(() {
          _errorMessage = res.data['message'] ?? 'ভুল ওটিপি কোড';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'যাচাই ব্যর্থ হয়েছে। সঠিক কোড দিন।';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('সাবস্ক্রিপশ�'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStepper(),
              const SizedBox(height: 24),
              if (_currentStep == DcbFlowStep.selectingGateway) _buildGatewaySelectionCard(),
              if (_currentStep == DcbFlowStep.enteringPhone) _buildPhoneEntryCard(),
              if (_currentStep == DcbFlowStep.operatorUnsupported) _buildUnsupportedOperatorCard(),
              if (_currentStep == DcbFlowStep.verifyingOtp) _buildOtpVerificationCard(),
              if (_currentStep == DcbFlowStep.subscribedSuccess) _buildSuccessCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepper() {
    int stepNum = 1;
    if (_currentStep == DcbFlowStep.enteringPhone) stepNum = 2;
    if (_currentStep == DcbFlowStep.verifyingOtp) stepNum = 3;
    if (_currentStep == DcbFlowStep.subscribedSuccess) stepNum = 4;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _stepperNode('১', 'গেটওয়ে', stepNum >= 1, stepNum > 1),
          _stepperLine(stepNum > 1),
          _stepperNode('২', 'নম্বর দিন', stepNum >= 2, stepNum > 2),
          _stepperLine(stepNum > 2),
          _stepperNode('৩', 'যাচাই করুন', stepNum >= 3, stepNum > 3),
          _stepperLine(stepNum > 3),
          _stepperNode('৪', 'সব প্রস্তুত', stepNum >= 4, false),
        ],
      ),
    );
  }

  Widget _stepperNode(String num, String label, bool active, bool done) {
    return Row(
      children: [
        CircleAvatar(
          radius: 13,
          backgroundColor: done ? Colors.green : (active ? AppTheme.primary : Colors.grey.shade300),
          child: done
              ? const Icon(Icons.check, size: 14, color: Colors.white)
              : Text(num, style: TextStyle(fontSize: 12, color: active ? Colors.white : Colors.black54, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(fontSize: 12, fontWeight: active ? FontWeight.bold : FontWeight.normal)),
      ],
    );
  }

  Widget _stepperLine(bool active) {
    return Expanded(
      child: Container(
        height: 2,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        color: active ? Colors.green : Colors.grey.shade300,
      ),
    );
  }

  Widget _buildGatewaySelectionCard() {
    if (_isLoading && _gateways.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.account_balance_wallet, size: 56, color: AppTheme.primary),
            const SizedBox(height: 12),
            const Text('পেমেন্ট মাধ্যম নির্বাচন করুন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 6),
            const Text('আপনি কোন মাধ্যমে পেমেন্ট করতে চান?', style: TextStyle(fontSize: 13, color: Colors.black54), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ..._gateways.map((gateway) => _buildGatewayOption(gateway)),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGatewayOption(BillingGateway gateway) {
    final isSelected = _selectedGateway == gateway.code;
    final isDefault = gateway.code == _defaultGateway;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(color: isSelected ? AppTheme.primary : Colors.grey.shade300, width: isSelected ? 2 : 1),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? AppTheme.primary.withOpacity(0.05) : Colors.white,
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedGateway = gateway.code;
          });
          _proceedWithGateway(gateway);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Icon(gateway.typeIcon, size: 32, color: isSelected ? AppTheme.primary : Colors.grey),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(gateway.name, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: isSelected ? AppTheme.primary : Colors.black87)),
                        if (isDefault) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(color: Colors.green.shade100, borderRadius: BorderRadius.circular(4)),
                            child: const Text('ডিফল্ট', style: TextStyle(fontSize: 10, color: Colors.green, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(gateway.description, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                    const SizedBox(height: 4),
                    Text(gateway.typeLabel, style: TextStyle(fontSize: 11, color: Colors.grey.shade600, fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
              if (isSelected) const Icon(Icons.check_circle, color: AppTheme.primary, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  void _proceedWithGateway(BillingGateway gateway) {
    if (gateway.type == 'carrier_billing') {
      setState(() {
        _currentStep = DcbFlowStep.enteringPhone;
      });
    } else {
      _initiateGatewayPayment(gateway);
    }
  }

  Future<void> _initiateGatewayPayment(BillingGateway gateway) async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final dio = ref.read(dioClientProvider).dio;
      final res = await dio.post(ApiEndpoints.paymentsInitiate, data: {
        'gateway': gateway.code,
        'amount': 200,
        'payable_type': 'subscription',
      });

      if (res.data['success'] == true) {
        final redirectUrl = res.data['redirect_url'];
        if (redirectUrl != null && redirectUrl.isNotEmpty) {
          // TODO: Open WebView or redirect to browser
          setState(() {
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = res.data['message'] ?? 'পেমেন্ট শুরু করা যায়নি';
          });
        }
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = res.data['message'] ?? 'পেমেন্ট শুরু করা যায়নি';
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'পেমেন্ট শুরু করা যায়নি। আবার চেষ্টা করুন।';
      });
    }
  }

  Widget _buildPhoneEntryCard() {
    final selectedGateway = _gateways.firstWhere(
      (g) => g.code == _selectedGateway,
      orElse: () => BillingGateway(code: '', name: 'মোবাইল বিল', type: 'carrier_billing', description: '', requiresPhone: true, operators: ['robi', 'airtel']),
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(selectedGateway.typeIcon, size: 56, color: AppTheme.primary),
            const SizedBox(height: 12),
            Text('আপনার ${selectedGateway.operators.isNotEmpty ? selectedGateway.operators.map((o) => o == 'robi' ? 'রবি' : 'এয়ারটেল').join(' বা ') : 'মোবাইল'} নম্বর দিন', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 6),
            const Text('কোনো পাসওয়ার্ডের প্রয়োজন নেই, ওটিপি দিয়েই সক্রিয় হবে', style: TextStyle(fontSize: 13, color: Colors.black54), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(color: Colors.blue.shade50, borderRadius: BorderRadius.circular(8)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('সব প্রিমিয়াম ফিচারে এক্সেস', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.blue)),
                  Chip(label: Text('২ ৳ / দিন', style: TextStyle(fontSize: 11, color: Colors.white)), backgroundColor: AppTheme.primary, padding: EdgeInsets.zero),
                ],
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              maxLength: 11,
              decoration: InputDecoration(
                prefixText: '+88 ',
                labelText: 'মোবাইল নম্বর',
                hintText: '018XXXXXXXX',
                border: const OutlineInputBorder(),
                helperText: selectedGateway.operators.isNotEmpty
                    ? 'শুধুমাত্র ${selectedGateway.operators.map((o) => o == 'robi' ? 'রবি (018)' : 'এয়ারটেল (016)').join(' বা ')} নম্বর দিন'
                    : 'আপনার মোবাইল নম্বর দিন',
              ),
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _handlePhoneSubmit,
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('কোড পাঠান →', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = DcbFlowStep.selectingGateway;
                });
              },
              child: const Text('অন্য পেমেন্ট মাধ্যম নির্বাচন করুন', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUnsupportedOperatorCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.sim_card_alert, size: 56, color: Colors.amber),
            const SizedBox(height: 12),
            const Text('অপারেটর সমর্থিত নয়', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.amber.shade50, borderRadius: BorderRadius.circular(8)),
              child: Text(
                'আপনার নম্বরটি ($_unsupportedOperatorName) বর্তমানে সমর্থিত নয়। সেবাটি শুধুমাত্র রবি (018) এবং এয়ারটেল (016) ব্যালেন্সের জন্য প্রযোজ্য।',
                style: const TextStyle(fontSize: 13, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => setState(() => _currentStep = DcbFlowStep.enteringPhone),
              icon: const Icon(Icons.arrow_back),
              label: const Text('রবি বা এয়ারটেল নম্বর দিন'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                setState(() {
                  _currentStep = DcbFlowStep.selectingGateway;
                });
              },
              child: const Text('অন্য পেমেন্ট মাধ্যম ব্যবহার করুন', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpVerificationCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(Icons.lock_clock, size: 56, color: Colors.green),
            const SizedBox(height: 12),
            const Text('ওটিপি কোড দিন', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text('${_phoneController.text} নম্বরে পাঠানো ৬ সংখ্যার কোডটি দিন', style: const TextStyle(fontSize: 13, color: Colors.black54)),
            TextButton(
              onPressed: () => setState(() => _currentStep = DcbFlowStep.enteringPhone),
              child: const Text('নম্বর পরিবর্তন করুন', style: TextStyle(fontSize: 12)),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 42,
                  height: 52,
                  child: TextField(
                    controller: _otpDigitControllers[index],
                    focusNode: _otpFocusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    decoration: const InputDecoration(counterText: '', border: OutlineInputBorder()),
                    onChanged: (val) {
                      if (val.isNotEmpty && index < 5) {
                        _otpFocusNodes[index + 1].requestFocus();
                      } else if (val.isEmpty && index > 0) {
                        _otpFocusNodes[index - 1].requestFocus();
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
                  onPressed: _timerSeconds == 0 ? _handlePhoneSubmit : null,
                  child: const Text('পুনরায় কোড পাঠান', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(_errorMessage!, style: const TextStyle(color: Colors.red, fontSize: 12), textAlign: TextAlign.center),
              ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleVerifyAndSubscribe,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green, minimumSize: const Size.fromHeight(48), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
              child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white)) : const Text('যাচাই ও সাবস্ক্রাইব', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuccessCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 36, horizontal: 20),
        child: Column(
          children: [
            CircleAvatar(radius: 36, backgroundColor: Colors.green, child: Icon(Icons.check, size: 40, color: Colors.white)),
            SizedBox(height: 16),
            Text('সব প্রস্তুত!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('আপনার সাবস্ক্রিপশন ও একাউন্ট সক্রিয় হয়েছে', style: TextStyle(fontSize: 14, color: Colors.black54)),
            SizedBox(height: 16),
            CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}
