import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/app.dart';
import 'package:livemcq3/core/providers/app_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(initializeAppProvider.future);

  runApp(UncontrolledProviderScope(container: container, child: const LiveMcq3App()));
}
