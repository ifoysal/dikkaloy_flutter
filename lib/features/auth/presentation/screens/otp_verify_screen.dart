import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class OtpVerifyScreen extends ConsumerStatefulWidget {
  final String phone;

  const OtpVerifyScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends ConsumerState<OtpVerifyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();
  bool _isResending = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _verifyOtp() async {
    if (!_formKey.currentState!.validate()) return;
    final otp = _otpController.text.trim();
    try {
      await ref.read(authNotifierProvider.notifier).verifyOtp(widget.phone, otp);
      final authState = ref.read(authNotifierProvider);
      if (!authState.hasError) {
        if (mounted) context.go('/home');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.error),
        );
      }
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _isResending = true);
    try {
      await ref.read(authNotifierProvider.notifier).sendOtp(widget.phone);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('\u0993\u099F\u09BF\u09AA\u09BF' + ' \u09AA\u09BE\u09A0\u09BE\u09A8\u09CB' + ' \u09B9\u09AF\u09BC\u09C7\u099B\u09C7')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.error),
        );
      }
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('\u0993\u099F\u09BF\u09AA\u09BF' + ' \u09AF\u09BE\u099A\u09BE\u0987')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.sms, size: 80, color: AppTheme.primary),
                const SizedBox(height: 24),
                Text(
                  widget.phone + ' \u09A8\u09AE\u09CD\u09AC\u09B0\u09C7 \u09AA\u09BE\u09A0\u09BE\u09A8\u09CB \u0993\u099F\u09BF\u09AA\u09BF \u09A6\u09BF\u09A8',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _otpController,
                  decoration: InputDecoration(labelText: '\u0993\u099F\u09BF\u09AA\u09BF'),
                  keyboardType: TextInputType.number,
                  validator: (v) => v != null && v.length >= 4 ? null : '\u0993\u099F\u09BF\u09AA\u09BF' + ' \u09A6\u09BF\u09A8',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _verifyOtp,
                  child: isLoading
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.onPrimary))
                      : Text('\u09AF\u09BE\u099A\u09BE\u0987' + ' \u0995\u09B0\u09C1\u09A8'),
                ),
                TextButton(
                  onPressed: _isResending ? null : _resendOtp,
                  child: _isResending
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator())
                      : Text('\u0993\u099F\u09BF\u09AA\u09BF' + ' \u09AA\u09C1\u09A8\u09B0\u09BE\u09AF\u09BC' + ' \u09AA\u09BE\u09A0\u09BE\u09A8'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}