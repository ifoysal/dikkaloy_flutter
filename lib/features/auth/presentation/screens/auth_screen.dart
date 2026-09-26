import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

/// Phone-only DCB (BDApps) login: enter a Robi/Airtel number, verify the
/// OTP BDApps sends, and get logged in. If the number already has an active
/// BDApps subscription, the backend logs the user in without an OTP step.
class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  static final _phoneRegex = RegExp(r'^01[68]\d{8}$');

  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  int _step = 0; // 0 = phone entry, 1 = otp verify
  bool _isSubmitting = false;
  String? _errorMessage;

  Timer? _resendTimer;
  int _resendSeconds = 60;

  @override
  void dispose() {
    _resendTimer?.cancel();
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    setState(() => _resendSeconds = 60);
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_resendSeconds <= 1) {
        timer.cancel();
        setState(() => _resendSeconds = 0);
      } else {
        setState(() => _resendSeconds--);
      }
    });
  }

  String get _cleanPhone => _phoneController.text.trim().replaceAll(RegExp(r'\s+|-'), '');

  Future<void> _handleSendOtp() async {
    final phone = _cleanPhone;
    if (!_phoneRegex.hasMatch(phone)) {
      setState(() => _errorMessage = 'শুধুমাত্র রবি (018) বা এয়ারটেল (016) নম্বর দিন, যেমন: 018XXXXXXXX');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    final notifier = ref.read(authNotifierProvider.notifier);

    try {
      final check = await notifier.checkOperator(phone);
      if (check['eligible'] != true) {
        setState(() {
          _isSubmitting = false;
          _errorMessage = check['message'] ?? 'দুঃখিত, এই নম্বরটি সমর্থিত নয়। শুধুমাত্র রবি বা এয়ারটেল নম্বর দিন।';
        });
        return;
      }

      final result = await notifier.requestDcbOtp(phone);

      if (!mounted) return;

      if (result.alreadyLoggedIn) {
        context.go('/home');
        return;
      }

      setState(() {
        _step = 1;
        _isSubmitting = false;
      });
      _startResendTimer();
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  Future<void> _handleVerifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 4) {
      setState(() => _errorMessage = 'সম্পূর্ণ ওটিপি কোড দিন');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      await ref.read(authNotifierProvider.notifier).verifyDcbOtp(_cleanPhone, otp);
      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      setState(() {
        _isSubmitting = false;
        _errorMessage = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: AppTheme.primary,
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(color: AppTheme.primary.withOpacity(0.25), blurRadius: 20, offset: const Offset(0, 8)),
                          ],
                        ),
                        child: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.school, size: 48, color: Colors.white),
                            SizedBox(height: 8),
                            Text('দিক্ষালয়', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),
                      Container(
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          color: AppTheme.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black.withOpacity(0.06)),
                          boxShadow: [
                            BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 16, offset: const Offset(0, 6)),
                          ],
                        ),
                        child: _step == 0 ? _buildPhoneStep() : _buildOtpStep(),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhoneStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('রবি ও এয়ারটেল লগইন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text(
          'লগইন শুধুমাত্র রবি (018) এবং এয়ারটেল (016) নম্বরে কার্যকর। আপনার নম্বরটি লিখুন:',
          style: TextStyle(fontSize: 13, color: Colors.black54, height: 1.4),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 11,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.0),
          decoration: InputDecoration(
            prefixText: '+88 ',
            counterText: '',
            hintText: '018XXXXXXXX',
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(_errorMessage!, style: const TextStyle(color: AppTheme.error, fontSize: 12)),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: _isSubmitting ? null : _handleSendOtp,
            child: _isSubmitting
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                : const Text('কোড পাঠান', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildOtpStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('ওটিপি কোড দিন', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            TextButton(
              onPressed: () => setState(() {
                _step = 0;
                _errorMessage = null;
              }),
              child: const Text('নম্বর পরিবর্তন', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
        Text('$_cleanPhone নম্বরে পাঠানো কোডটি লিখুন', style: const TextStyle(fontSize: 13, color: Colors.black54)),
        const SizedBox(height: 20),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          maxLength: 6,
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, letterSpacing: 8),
          decoration: InputDecoration(
            counterText: '',
            hintText: '••••••',
            filled: true,
            fillColor: AppTheme.background,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
          ),
        ),
        if (_errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(_errorMessage!, style: const TextStyle(color: AppTheme.error, fontSize: 12)),
        ],
        const SizedBox(height: 20),
        SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            ),
            onPressed: _isSubmitting ? null : _handleVerifyOtp,
            child: _isSubmitting
                ? const SizedBox(width: 22, height: 22, child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white))
                : const Text('যাচাই ও লগইন', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(height: 12),
        Center(
          child: _resendSeconds > 0
              ? Text('আবার কোড পাঠানো যাবে ${_resendSeconds}s পর', style: const TextStyle(fontSize: 12, color: Colors.black54))
              : TextButton(
                  onPressed: _isSubmitting ? null : _handleSendOtp,
                  child: const Text('পুনরায় কোড পাঠান', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
        ),
      ],
    );
  }
}
