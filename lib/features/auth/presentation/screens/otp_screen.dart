import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/features/auth/presentation/providers/auth_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  const OtpScreen({super.key});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();
  bool _isVerifyMode = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.isEmpty) return;
    await ref.read(authProvider.notifier).sendOtp(phone);
    setState(() => _isVerifyMode = true);
  }

  Future<void> _verifyOtp() async {
    final phone = _phoneController.text.trim();
    final otp = _otpController.text.trim();
    if (phone.isEmpty || otp.isEmpty) return;
    await ref.read(authProvider.notifier).verifyOtp(phone, otp);
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final authState = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: Text(_isVerifyMode ? l10n.verifyOtp : l10n.sendOtp)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(labelText: l10n.phone),
              enabled: !_isVerifyMode,
            ),
            if (_isVerifyMode) ...[
              const SizedBox(height: 16),
              TextFormField(
                controller: _otpController,
                decoration: InputDecoration(labelText: l10n.otp),
                keyboardType: TextInputType.number,
              ),
            ],
            const SizedBox(height: 24),
            if (authState.value?.errorMessage != null)
              Text(authState.value!.errorMessage!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: authState.value?.isLoading == true
                  ? null
                  : (_isVerifyMode ? _verifyOtp : _sendOtp),
              child: Text(_isVerifyMode ? l10n.verifyOtp : l10n.sendOtp),
            ),
            if (!_isVerifyMode)
              TextButton(onPressed: _sendOtp, child: Text(l10n.resendOtp)),
          ],
        ),
      ),
    );
  }
}
