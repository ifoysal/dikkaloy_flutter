import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/features/mcq/domain/entities/category.dart';
import 'package:livemcq3/features/mcq/presentation/providers/mcq_provider.dart';

class CategoriesScreen extends ConsumerWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final asyncCategories = ref.watch(categoriesProvider);
    final isLoggedIn = ref.watch(authNotifierProvider).valueOrNull != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.categories),
        actions: [
          if (!isLoggedIn)
            TextButton.icon(
              onPressed: () => context.push('/auth'),
              icon: const Icon(Icons.login, color: Colors.white),
              label: const Text('লগইন', style: TextStyle(color: Colors.white)),
            ),
        ],
      ),
      body: asyncCategories.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (categories) {
          if (categories.isEmpty) return Center(child: Text(l10n.noData));
          return ListView.builder(
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: category.isPremium ? Colors.amber : Colors.green,
                    child: Icon(
                      category.isPremium ? Icons.lock : Icons.quiz,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(category.name),
                  subtitle: Text('${category.questionCount} questions'),
                  trailing: category.isPremium
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.amber,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                '৳${category.priceBdt}',
                                style: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
                          ],
                        )
                      : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                  onTap: () => _onCategoryTap(context, category, isLoggedIn),
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _onCategoryTap(BuildContext context, Category category, bool isLoggedIn) {
    if (category.isPremium) {
      context.push('/quiz/payment-gate/${category.id}', extra: {
        'categoryName': category.name,
        'pricePoisha': category.pricePoisha,
      });
    } else {
      context.push('/practice/${category.id}');
    }
  }
}
