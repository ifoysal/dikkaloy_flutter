import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/contest_providers.dart';
import 'package:livemcq3/core/widgets/loading_skeleton.dart';

class ContestsScreen extends ConsumerWidget {
  const ContestsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contestsAsync = ref.watch(contestsProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('লাইভ কনটেস্ট (Live Contests)'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(contestsProvider),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(contestsProvider),
        child: contestsAsync.when(
          loading: () => const LoadingSkeleton(),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (contests) {
            if (contests.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.emoji_events_outlined, size: 64, color: Colors.grey.shade400),
                    const SizedBox(height: 16),
                    const Text(
                      'আপাতত কোনো সক্রিয় কনটেস্ট নেই',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: contests.length,
              itemBuilder: (context, index) {
                final contest = contests[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: const BorderSide(color: Color(0xFFE2E8F0)),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEE2E2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Row(
                                children: [
                                  CircleAvatar(radius: 4, backgroundColor: Color(0xFFDC2626)),
                                  SizedBox(width: 6),
                                  Text('লাইভ এরিনা', style: TextStyle(color: Color(0xFFDC2626), fontSize: 11, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            if (contest.isPremium == true)
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEF3C7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  children: [
                                    Icon(Icons.stars, size: 12, color: Color(0xFFD97706)),
                                    SizedBox(width: 4),
                                    Text('প্রিমিয়াম', style: TextStyle(fontSize: 10, color: Color(0xFFB45309), fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          contest.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.access_time, size: 14, color: Color(0xFF64748B)),
                            const SizedBox(width: 6),
                            Text(
                              'সময়: ${contest.startTime} - ${contest.endTime}',
                              style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 42,
                          child: ElevatedButton(
                            onPressed: () {
                              if (contest.isPremium == true && contest.hasAccess != true) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('প্রিমিয়াম অ্যাক্সেস প্রয়োজন')),
                                );
                                return;
                              }
                              if (contest.hasJoined != true) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    title: const Text('কনটেস্টে যুক্ত হন'),
                                    content: const Text('লাইভ এরিনায় প্রবেশের পূর্বে কনটেস্টে যুক্ত হতে হবে।'),
                                    actions: [
                                      TextButton(onPressed: () => Navigator.pop(context), child: const Text('বাতিল')),
                                      ElevatedButton(
                                        onPressed: () async {
                                          await ref.read(contestRepositoryProvider).joinContest(contest.id);
                                          ref.invalidate(contestsProvider);
                                          if (context.mounted) {
                                            Navigator.pop(context);
                                            context.push('/home/contests/${contest.id}/arena');
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0284C7)),
                                        child: const Text('যুক্ত হোন', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );
                                return;
                              }
                              context.push('/home/contests/${contest.id}/arena');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0284C7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              elevation: 0,
                            ),
                            child: const Text('এরিনায় প্রবেশ করুন', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
