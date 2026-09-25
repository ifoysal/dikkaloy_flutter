import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class PhoneLoginScreen extends ConsumerStatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  ConsumerState<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends ConsumerState<PhoneLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    final phone = _phoneController.text.trim();
    try {
      await ref.read(authNotifierProvider.notifier).sendOtp(phone);
      if (mounted) {
        context.push('/otp-verify', extra: phone);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString()), backgroundColor: AppTheme.error),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authNotifierProvider).isLoading;

    return Scaffold(
      appBar: AppBar(title: Text('\u09AB\u09CB\u09A8' + ' \u09B2\u0997\u0987\u09A8')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.phone, size: 80, color: AppTheme.primary),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: '\u09AB\u09CB\u09A8' + ' \u09A8\u09AE\u09CD\u09AC\u09B0'),
                  keyboardType: TextInputType.phone,
                  validator: (v) => v != null && v.length >= 10 ? null : '\u09B8\u09A0\u09BF\u0995' + ' \u09AB\u09CB\u09A8' + ' \u09A8\u09AE\u09CD\u09AC\u09B0' + ' \u09A6\u09BF\u09A8',
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: isLoading ? null : _sendOtp,
                  child: isLoading
                      ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.onPrimary))
                      : Text('\u0993\u099F\u09BF\u09AA\u09BF' + ' \u09AA\u09BE\u09A0\u09BE\u09A8'),
                ),
                TextButton(
                  onPressed: () => context.push('/login'),
                  child: Text('\u0987\u09AE\u09C7\u0987\u09B2/\u09AA\u09BE\u09B8\u0993\u09AF\u09BC\u09BE\u09B0\u09CD\u09A1' + ' \u09A6\u09BF\u09AF\u09BC\u09C7' + ' \u09B2\u0997\u0987\u09A8' + ' \u0995\u09B0\u09C1\u09A8'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}