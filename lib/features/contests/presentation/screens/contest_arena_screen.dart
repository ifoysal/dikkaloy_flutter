import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/l10n/app_localizations.dart';
import 'package:livemcq3/core/network/websocket_client.dart';
import 'package:livemcq3/features/contest/data/repositories/contest_repository_impl.dart';
import 'package:livemcq3/features/contest/presentation/providers/contest_provider.dart';

class ContestArenaScreen extends ConsumerStatefulWidget {
  final int contestId;
  const ContestArenaScreen({super.key, required this.contestId});

  @override
  ConsumerState<ContestArenaScreen> createState() => _ContestArenaScreenState();
}

class _ContestArenaScreenState extends ConsumerState<ContestArenaScreen> {
  final Map<int, int> _selectedAnswers = {};
  int _currentQuestionIndex = 0;
  bool _isConnected = false;
  String _connectionStatus = 'Connecting...';

  @override
  void initState() {
    super.initState();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    try {
      final wsClient = WebSocketClient(
        appKey: const String.fromEnvironment('REVERB_APP_KEY', defaultValue: 'dikkhaloy_key'),
        host: const String.fromEnvironment('REVERB_HOST', defaultValue: 'wss://dikkhaloy.nothibazar.com.bd'),
      );
      wsClient.connect();
      wsClient.subscribe('contest.${widget.contestId}');

      setState(() {
        _isConnected = true;
        _connectionStatus = 'Live Connected';
      });
    } catch (e) {
      setState(() {
        _isConnected = false;
        _connectionStatus = 'Offline';
      });
    }
  }

  Future<void> _submitAnswer(int questionId, int optionId) async {
    setState(() => _selectedAnswers[questionId] = optionId);
    try {
      final repo = ref.read(contestRepositoryProvider) as ContestRepositoryImpl;
      await repo.submit(widget.contestId, {questionId: optionId});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${AppLocalizations.of(context).error}: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final contestAsync = ref.watch(contestDetailProvider(widget.contestId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Contest Arena'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: _isConnected ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(radius: 3, backgroundColor: Colors.white),
                    const SizedBox(width: 4),
                    Text(
                      _connectionStatus,
                      style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      body: contestAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('${l10n.error}: $e')),
        data: (contest) {
          return const Center(child: Text('Live contest arena - questions stream via WebSocket'));
        },
      ),
    );
  }
}
