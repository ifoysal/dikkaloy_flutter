import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/constants/app_constants.dart';
import 'package:livemcq3/core/storage/hive_boxes.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _pages = [
    {'title': 'Welcome to LiveMCQ', 'subtitle': 'Your one-stop platform for exam preparation, job alerts, and skill building.', 'icon': 'school'},
    {'title': 'Practice MCQs', 'subtitle': 'Thousands of curated questions for BCS, Bank, NTRCA, and more.', 'icon': 'quiz'},
    {'title': 'Live Contests', 'subtitle': 'Compete with peers in real-time MCQ contests and climb the leaderboard.', 'icon': 'emoji_events'},
    {'title': 'Get Started', 'subtitle': 'Create your account and start your journey today.', 'icon': 'arrow_forward'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) {
                  final page = _pages[index];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_getIconData(page['icon']!), size: 120, color: AppTheme.primary),
                        const SizedBox(height: 48),
                        Text(
                          page['title']!,
                          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          page['subtitle']!,
                          style: Theme.of(context).textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: List.generate(_pages.length, (index) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: _currentPage == index ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index ? AppTheme.primary : AppTheme.secondary.withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_currentPage == _pages.length - 1) {
                        await HiveBoxes.getUserBox().put(AppConstants.onboardingKey, true);
                        context.go('/login');
                      } else {
                        _pageController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
                      }
                    },
                    child: Text(_currentPage == _pages.length - 1 ? 'Get Started' : 'Next'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'school':
        return Icons.school;
      case 'quiz':
        return Icons.quiz;
      case 'emoji_events':
        return Icons.emoji_events;
      case 'arrow_forward':
        return Icons.arrow_forward;
      default:
        return Icons.star;
    }
  }
}
