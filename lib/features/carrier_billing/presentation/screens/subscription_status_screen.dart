import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/providers/carrier_billing_provider.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class SubscriptionStatusScreen extends ConsumerWidget {
  const SubscriptionStatusScreen({super.key});

  Future<void> _unsubscribe(BuildContext context, WidgetRef ref) async {
    final state = ref.read(carrierBillingProvider);
    final subscriptionId = (state.subscriptionData?['id'] as int?) ?? 0;
    if (subscriptionId == 0) return;
    final success = await ref.read(carrierBillingProvider.notifier).unsubscribe(subscriptionId);
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).ok)),
      );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(carrierBillingProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Carrier Subscription')),
      body: RefreshIndicator(
        onRefresh: () => ref.read(carrierBillingProvider.notifier).loadStatus(),
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            if (state.isLoading)
              const Center(child: CircularProgressIndicator())
            else if (state.subscriptionData != null)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status: ${state.subscriptionData!['status'] ?? 'Unknown'}', style: Theme.of(context).textTheme.bodyLarge),
                      const SizedBox(height: 8),
                      Text('MSISDN: ${state.subscriptionData!['msisdn'] ?? '-'}'),
                      const SizedBox(height: 8),
                      Text('Subscriber ID: ${state.subscriptionData!['subscriber_id'] ?? '-'}'),
                      const SizedBox(height: 24),
                      if (state.subscriptionData!['status'] == 'REGISTERED')
                        ElevatedButton.icon(
                          onPressed: () => _unsubscribe(context, ref),
                          icon: const Icon(Icons.cancel),
                          label: const Text('Unsubscribe'),
                          style: ElevatedButton.styleFrom(backgroundColor: AppTheme.error),
                        )
                      else
                        ElevatedButton.icon(
                          onPressed: () => context.push('/carrier-billing'),
                          icon: const Icon(Icons.phone),
                          label: const Text('Activate Subscription'),
                        ),
                    ],
                  ),
                ),
              )
            else
              Center(
                child: Column(
                  children: [
                    const Icon(Icons.phonelink_erase, size: 64, color: AppTheme.primary),
                    const SizedBox(height: 24),
                    Text('No active carrier subscription', style: Theme.of(context).textTheme.bodyLarge),
                    const SizedBox(height: 24),
                    ElevatedButton.icon(
                      onPressed: () => context.push('/carrier-billing'),
                      icon: const Icon(Icons.phone),
                      label: const Text('Activate Subscription'),
                    ),
                  ],
                ),
              ),
            if (state.isError)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  state.message ?? l10n.error,
                  style: const TextStyle(color: AppTheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
