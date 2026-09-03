import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/auth_providers.dart';
import 'package:livemcq3/core/providers/book_providers.dart';
import 'package:livemcq3/core/providers/contest_providers.dart';
import 'package:livemcq3/core/providers/job_providers.dart';
import 'package:livemcq3/core/providers/mcq_providers.dart';
import 'package:livemcq3/core/widgets/loading_skeleton.dart';
import 'package:livemcq3/core/themes/app_theme.dart';
import 'package:livemcq3/data/models/user_model.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final contestsAsync = ref.watch(contestsProvider);
    final jobsAsync = ref.watch(jobsProvider((search: null, categoryId: null, location: null)));
    final purchasesAsync = ref.watch(purchasesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveMCQ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/home/notifications'),
          ),
          if (authState.valueOrNull != null)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: AppTheme.onPrimary,
                child: Text(
                  authState.valueOrNull!.name.isNotEmpty
                      ? authState.valueOrNull!.name[0].toUpperCase()
                      : '?',
                  style: const TextStyle(color: AppTheme.primary, fontWeight: FontWeight.bold),
                ),
              ),
            ),
        ],
      ),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Not logged in'));
          }
          return RefreshIndicator(
            onRefresh: () async {
              ref.invalidate(contestsProvider);
              ref.invalidate(jobsProvider);
              ref.invalidate(purchasesProvider);
              ref.invalidate(examCategoriesProvider);
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(
                      'Hello, ${user.name.split(' ').first}!',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildQuickStats(context, user),
                  const SizedBox(height: 24),
                  _buildFeatureGrid(context, user),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Upcoming Contests', () => context.push('/home/contests')),
                  const SizedBox(height: 12),
                  _buildContestsPreview(context, contestsAsync),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Recent Jobs', () => context.push('/home/jobs')),
                  const SizedBox(height: 12),
                  _buildJobsPreview(context, jobsAsync),
                  const SizedBox(height: 24),
                  _buildSectionHeader('Continue Reading', () => context.push('/home/books')),
                  const SizedBox(height: 12),
                  _buildBooksPreview(context, purchasesAsync),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() => _currentIndex = index);
          final route = switch (index) {
            0 => '/home',
            1 => '/home/practice',
            2 => '/home/jobs',
            3 => '/home/books',
            4 => '/home/profile',
            _ => '/home',
          };
          context.go(route);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.quiz), label: 'MCQ'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Jobs'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Books'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildFeatureGrid(BuildContext context, UserModel user) {
    const features = <_FeatureItem>[
      _FeatureItem(
        title: 'Daily Quiz',
        icon: Icons.quiz,
        color: AppTheme.accent,
        route: '/home/quiz',
      ),
      _FeatureItem(
        title: 'Syllabus',
        icon: Icons.list_alt,
        color: AppTheme.secondary,
        route: '/home/syllabus',
      ),
      _FeatureItem(
        title: 'Courses',
        icon: Icons.play_circle_fill,
        color: AppTheme.primary,
        route: '/home/courses',
      ),
      _FeatureItem(
        title: 'Job Alerts',
        icon: Icons.notifications_active,
        color: AppTheme.accent,
        route: '/home/job-alerts',
      ),
      _FeatureItem(
        title: 'CV Builder',
        icon: Icons.badge,
        color: AppTheme.secondary,
        route: '/home/cv-builder',
      ),
      _FeatureItem(
        title: 'My Applications',
        icon: Icons.assignment,
        color: AppTheme.primary,
        route: '/home/applications',
      ),
      _FeatureItem(
        title: 'Library',
        icon: Icons.local_library,
        color: AppTheme.accent,
        route: '/home/library',
      ),
      _FeatureItem(
        title: 'Analytics',
        icon: Icons.analytics,
        color: AppTheme.secondary,
        route: '/home/analytics',
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        final feature = features[index];
        return Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: InkWell(
            onTap: () => context.push(feature.route),
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(feature.icon, color: feature.color, size: 28),
                  const SizedBox(height: 8),
                  Text(
                    feature.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        TextButton(onPressed: onTap, child: const Text('See All')),
      ],
    );
  }

  Widget _buildQuickStats(BuildContext context, user) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Practice Streak',
            value: '${user.totalExams ?? 0}',
            icon: Icons.local_fire_department,
            color: AppTheme.accent,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Points',
            value: '${user.totalPoints ?? 0}',
            icon: Icons.stars,
            color: AppTheme.secondary,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Premium',
            value: user.isPremium == true ? 'Yes' : 'No',
            icon: Icons.lock,
            color: AppTheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildContestsPreview(BuildContext context, AsyncValue contestsAsync) {
    return SizedBox(
      height: 140,
      child: contestsAsync.when(
        loading: () => const LoadingSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (contests) {
          if (contests.isEmpty) return const Center(child: Text('No upcoming contests'));
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: contests.length,
            itemBuilder: (context, index) {
              final contest = contests[index];
              return SizedBox(
                width: 200,
                child: Card(
                  child: ListTile(
                    leading: const Icon(Icons.emoji_events, color: AppTheme.accent),
                    title: Text(contest.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Starts: ${contest.startTime}'),
                    trailing: ElevatedButton(
                      onPressed: () {
                        if (contest.isPremium && !contest.hasAccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Premium access required')),
                          );
                          return;
                        }
                        context.push('/home/contests/${contest.id}/arena');
                      },
                      child: const Text('Join'),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildJobsPreview(BuildContext context, AsyncValue jobsAsync) {
    return SizedBox(
      height: 140,
      child: jobsAsync.when(
        loading: () => const LoadingSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (jobs) {
          if (jobs.isEmpty) return const Center(child: Text('No jobs available'));
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              return SizedBox(
                width: 240,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.work, color: AppTheme.secondary),
                    title: Text(job.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('${job.companyName}\nDeadline: ${job.deadline}'),
                    isThreeLine: true,
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.push('/home/jobs/${job.id}'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildBooksPreview(BuildContext context, AsyncValue purchasesAsync) {
    return SizedBox(
      height: 140,
      child: purchasesAsync.when(
        loading: () => const LoadingSkeleton(),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (purchases) {
          if (purchases.isEmpty) return const Center(child: Text('No books purchased yet'));
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: purchases.length,
            itemBuilder: (context, index) {
              final purchase = purchases[index];
              return SizedBox(
                width: 200,
                child: Card(
                  child: ListTile(
                    leading: Icon(Icons.menu_book, color: AppTheme.primary),
                    title: Text(purchase.book?.title ?? 'Book', maxLines: 1, overflow: TextOverflow.ellipsis),
                    subtitle: Text('Purchased: ${purchase.createdAt ?? ''}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.push('/home/books/${purchase.bookId}/reader'),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({required this.title, required this.value, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 12),
            Text(value, style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: color, fontWeight: FontWeight.bold)),
            Text(title, style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}

class _FeatureItem {
  final String title;
  final IconData icon;
  final Color color;
  final String route;

  const _FeatureItem({
    required this.title,
    required this.icon,
    required this.color,
    required this.route,
  });
}
