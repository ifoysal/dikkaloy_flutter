import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';

class BiometricLockWidget extends StatefulWidget {
  final VoidCallback onAuthenticated;

  const BiometricLockWidget({super.key, required this.onAuthenticated});

  @override
  State<BiometricLockWidget> createState() => _BiometricLockWidgetState();
}

class _BiometricLockWidgetState extends State<BiometricLockWidget> {
  final LocalAuthentication _auth = LocalAuthentication();
  bool _isAvailable = false;

  @override
  void initState() {
    super.initState();
    _checkBiometrics();
  }

  Future<void> _checkBiometrics() async {
    final canCheck = await _auth.canCheckBiometrics;
    final isAvailable = await _auth.getAvailableBiometrics();
    setState(() => _isAvailable = canCheck && isAvailable.isNotEmpty);
  }

  Future<void> _authenticate() async {
    try {
      final success = await _auth.authenticate(
        localizedReason: AppLocalizations.of(context).biometricLogin,
        biometricOnly: true,
      );
      if (success && mounted) widget.onAuthenticated();
    } catch (e) {
      // ignore biometric errors
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (!_isAvailable) return const SizedBox.shrink();
    return IconButton(
      icon: const Icon(Icons.fingerprint),
      onPressed: _authenticate,
      tooltip: l10n.biometricLogin,
    );
  }
}
