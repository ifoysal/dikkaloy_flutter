import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/core/providers/job_providers.dart';
import 'package:livemcq3/core/widgets/loading_error.dart';

class JobsScreen extends ConsumerStatefulWidget {
  const JobsScreen({super.key});

  @override
  ConsumerState<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends ConsumerState<JobsScreen> {
  final _searchController = TextEditingController();
  int? _selectedCategoryId;
  final Set<int> _savedJobIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = (search: _searchController.text.trim().isEmpty ? null : _searchController.text.trim(), categoryId: _selectedCategoryId, location: null);
    final jobsAsync = ref.watch(jobsProvider(params));
    final categoriesAsync = ref.watch(jobCategoriesProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'চাকরি খুঁজুন (পদবী, কোম্পানি)...',
              hintStyle: TextStyle(color: Colors.white70, fontSize: 13),
              prefixIcon: Icon(Icons.search, color: Colors.white70, size: 20),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 10),
            ),
            style: const TextStyle(color: Colors.white, fontSize: 14),
            onChanged: (_) => setState(() {}),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            tooltip: 'Saved Jobs',
            onPressed: () => context.go('/home/jobs/saved'),
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter Chips Horizontal Bar
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: categoriesAsync.when(
              loading: () => const SizedBox(height: 36, child: Center(child: CircularProgressIndicator())),
              error: (_, __) => const SizedBox.shrink(),
              data: (categories) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ChoiceChip(
                        label: const Text('সব ক্যাটাগরি'),
                        selected: _selectedCategoryId == null,
                        selectedColor: const Color(0xFF0284C7),
                        labelStyle: TextStyle(
                          color: _selectedCategoryId == null ? Colors.white : const Color(0xFF475569),
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                        backgroundColor: const Color(0xFFF1F5F9),
                        onSelected: (selected) {
                          if (selected) setState(() => _selectedCategoryId = null);
                        },
                      ),
                      const SizedBox(width: 8),
                      ...categories.map((cat) {
                        final isSelected = _selectedCategoryId == cat.id;
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ChoiceChip(
                            label: Text(cat.name),
                            selected: isSelected,
                            selectedColor: const Color(0xFF0284C7),
                            labelStyle: TextStyle(
                              color: isSelected ? Colors.white : const Color(0xFF475569),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                            backgroundColor: const Color(0xFFF1F5F9),
                            onSelected: (selected) {
                              setState(() {
                                _selectedCategoryId = selected ? cat.id : null;
                              });
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                );
              },
            ),
          ),

          // Jobs Feed List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(jobsProvider(params));
                ref.invalidate(jobCategoriesProvider);
              },
              child: jobsAsync.when(
              loading: () => const LoadingOverlay(isLoading: true, child: SizedBox.shrink()),
              error: (e, _) => ErrorBanner(message: e.toString(), onRetry: () => ref.refresh(jobsProvider(params))),
              data: (jobs) {
                if (jobs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.work_off_outlined, size: 64, color: Colors.grey.shade400),
                        const SizedBox(height: 16),
                        const Text(
                          'কোনো চাকরি খুঁজে পাওয়া যায়নি',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF64748B)),
                        ),
                      ],
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    final isSaved = _savedJobIds.contains(job.id);

                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: const BorderSide(color: Color(0xFFE2E8F0)),
                      ),
                      elevation: 0,
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => context.push('/home/jobs/${job.id}'),
                        borderRadius: BorderRadius.circular(16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0FDF4),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: const Color(0xFFBBF7D0)),
                                    ),
                                    child: const Icon(Icons.business_rounded, color: Color(0xFF16A34A), size: 24),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          job.title,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF0F172A),
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          job.companyName,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFF64748B),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                                      color: isSaved ? const Color(0xFF0284C7) : const Color(0xFF94A3B8),
                                    ),
                                    onPressed: () async {
                                      final repo = ref.read(jobRepositoryProvider);
                                      if (isSaved) {
                                        await repo.unsaveJob(job.id);
                                        setState(() => _savedJobIds.remove(job.id));
                                      } else {
                                        await repo.saveJob(job.id);
                                        setState(() => _savedJobIds.add(job.id));
                                      }
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 6,
                                children: [
                                  if (job.location != null && job.location!.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F5F9),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.location_on_outlined, size: 12, color: Color(0xFF64748B)),
                                          const SizedBox(width: 4),
                                          Text(job.location!, style: const TextStyle(fontSize: 11, color: Color(0xFF475569))),
                                        ],
                                      ),
                                    ),
                                  if (job.salaryRange != null && job.salaryRange!.isNotEmpty)
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFECFDF5),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.payments_outlined, size: 12, color: Color(0xFF059669)),
                                          const SizedBox(width: 4),
                                          Text(job.salaryRange!, style: const TextStyle(fontSize: 11, color: Color(0xFF059669), fontWeight: FontWeight.w600)),
                                        ],
                                      ),
                                    ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFEF3C7),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(Icons.calendar_today_outlined, size: 12, color: Color(0xFFD97706)),
                                        const SizedBox(width: 4),
                                        Text('মেয়াদ: ${job.deadline}', style: const TextStyle(fontSize: 11, color: Color(0xFFB45309), fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
        ],
      ),
    );
  }
}
