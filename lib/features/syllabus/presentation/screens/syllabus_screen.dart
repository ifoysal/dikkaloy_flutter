import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:livemcq3/features/syllabus/presentation/providers/syllabus_providers.dart';

class SyllabusScreen extends ConsumerWidget {
  const SyllabusScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final syllabusAsync = ref.watch(syllabusProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Syllabus'),
        actions: [
          IconButton(icon: const Icon(Icons.search), onPressed: () => showSearch(context: context, delegate: SyllabusSearchDelegate())),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(syllabusProvider),
        child: syllabusAsync.when(
          loading: () => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: const [Center(child: CircularProgressIndicator())],
          ),
          error: (e, _) => ListView(
            physics: const AlwaysScrollableScrollPhysics(),
            children: [Center(child: Text('Error: $e'))],
          ),
          data: (items) {
            if (items.isEmpty) {
              return const Center(child: Text('No syllabus items'));
            }
            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(item['name']?.toString() ?? ''),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.push('/home/syllabus/${item['id']}'),
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

class SyllabusSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [IconButton(icon: const Icon(Icons.clear), onPressed: () => query = '')];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => close(context, ''));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Center(child: Text('Search results'));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Type to search'));
  }
}
