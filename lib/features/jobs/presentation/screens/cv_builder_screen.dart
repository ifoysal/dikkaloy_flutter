import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/features/jobs/data/cv_repository.dart';
import 'package:livemcq3/core/themes/app_theme.dart';

class CvBuilderScreen extends ConsumerStatefulWidget {
  const CvBuilderScreen({super.key});

  @override
  ConsumerState<CvBuilderScreen> createState() => _CvBuilderScreenState();
}

class _CvBuilderScreenState extends ConsumerState<CvBuilderScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateCvDialog(BuildContext context, int templateId, String templateName) {
    final titleController = TextEditingController(text: '$templateName Version');
    String selectedStyle = 'cv';

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text('Create CV ($templateName)'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'CV Title', hintText: 'e.g. BCS / Bank Job CV'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedStyle,
                decoration: const InputDecoration(labelText: 'Format Style'),
                items: const [
                  DropdownMenuItem(value: 'cv', child: Text('Curriculum Vitae (CV)')),
                  DropdownMenuItem(value: 'resume', child: Text('Modern Resume')),
                ],
                onChanged: (val) {
                  if (val != null) setDialogState(() => selectedStyle = val);
                },
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ref.read(cvRepositoryProvider).createCv(
                    templateId: templateId,
                    title: titleController.text.trim(),
                    style: selectedStyle,
                  );
                  ref.invalidate(userCvsProvider);
                  if (mounted) {
                    Navigator.pop(ctx);
                    _tabController.animateTo(0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('CV created successfully!'), backgroundColor: Colors.green),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: $e'), backgroundColor: AppTheme.error),
                    );
                  }
                }
              },
              child: const Text('Create'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userCvsAsync = ref.watch(userCvsProvider);
    final cvTemplatesAsync = ref.watch(cvTemplatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Professional CV Builder'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.accent,
          labelColor: AppTheme.onPrimary,
          unselectedLabelColor: AppTheme.onPrimary.withValues(alpha: 0.7),
          tabs: const [
            Tab(icon: Icon(Icons.folder_shared), text: 'My CVs'),
            Tab(icon: Icon(Icons.dashboard_customize), text: 'Templates'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Tab 1: My Created CVs
          userCvsAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (cvs) {
              if (cvs.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.description_outlined, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('You haven\'t created any CVs yet.', style: TextStyle(fontSize: 16)),
                      const SizedBox(height: 12),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('Choose a Template'),
                        onPressed: () => _tabController.animateTo(1),
                      ),
                    ],
                  ),
                );
              }
              return RefreshIndicator(
                onRefresh: () async => ref.invalidate(userCvsProvider),
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cvs.length,
                  itemBuilder: (context, index) {
                    final cv = cvs[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    cv.title,
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Chip(
                                  label: Text(cv.status.toUpperCase(), style: const TextStyle(fontSize: 11)),
                                  backgroundColor: cv.status == 'final' ? Colors.green.shade100 : Colors.amber.shade100,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Text('Template: ${cv.template?.name ?? 'Standard Template'}', style: const TextStyle(color: Colors.grey)),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(Icons.copy, size: 16),
                                  label: const Text('Duplicate'),
                                  onPressed: () async {
                                    await ref.read(cvRepositoryProvider).duplicateCv(cv.id);
                                    ref.invalidate(userCvsProvider);
                                    if (context.mounted) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(content: Text('CV Duplicated!')),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.download, size: 16),
                                  label: const Text('PDF'),
                                  onPressed: () async {
                                    final url = await ref.read(cvRepositoryProvider).getPdfUrl(cv.id);
                                    if (context.mounted && url.isNotEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text('PDF Ready: $url')),
                                      );
                                    }
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: AppTheme.error),
                                  onPressed: () async {
                                    await ref.read(cvRepositoryProvider).deleteCv(cv.id);
                                    ref.invalidate(userCvsProvider);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),

          // Tab 2: Template Gallery
          cvTemplatesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
            data: (templates) {
              if (templates.isEmpty) {
                return const Center(child: Text('No templates found'));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: templates.length,
                itemBuilder: (context, index) {
                  final template = templates[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: AppTheme.primary.withValues(alpha: 0.08),
                            child: const Center(
                              child: Icon(Icons.article_outlined, size: 48, color: AppTheme.primary),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(template.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              const Text('ATS Compliant', style: TextStyle(fontSize: 12, color: Colors.green)),
                              const SizedBox(height: 8),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () => _showCreateCvDialog(context, template.id, template.name),
                                  child: const Text('Use Template', style: TextStyle(fontSize: 12)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
