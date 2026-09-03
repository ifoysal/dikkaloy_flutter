import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/utils/connectivity.dart';

class OfflineDownloadScreen extends ConsumerWidget {
  const OfflineDownloadScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.offlineMode)),
      body: Center(
        child: FutureBuilder<bool>(
          future: ConnectivityService.isConnected,
          builder: (context, snapshot) {
            final connected = snapshot.data ?? false;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(connected ? Icons.wifi : Icons.wifi_off_rounded, size: 64, color: connected ? Colors.green : Colors.red),
                const SizedBox(height: 16),
                Text(connected ? l10n.online : l10n.offline),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: connected ? () {
                    // Trigger download via provider
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.sync)));
                  } : null,
                  child: Text(l10n.sync),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
