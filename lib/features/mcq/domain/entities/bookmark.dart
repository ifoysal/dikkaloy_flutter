import 'package:equatable/equatable.dart';

class Bookmark extends Equatable {
  final int id;
  final int questionId;
  final String createdAt;

  const Bookmark({required this.id, required this.questionId, required this.createdAt});

  @override
  List<Object?> get props => [id, questionId, createdAt];
}

class WeakArea extends Equatable {
  final String topic;
  final double score;
  final int attempts;

  const WeakArea({required this.topic, required this.score, required this.attempts});

  @override
  List<Object?> get props => [topic, score, attempts];
}
