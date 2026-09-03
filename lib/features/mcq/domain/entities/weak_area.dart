import 'package:equatable/equatable.dart';

class WeakArea extends Equatable {
  final String topic;
  final double score;
  final int attempts;

  const WeakArea({required this.topic, required this.score, required this.attempts});

  @override
  List<Object?> get props => [topic, score, attempts];

  factory WeakArea.fromJson(Map<String, dynamic> json) => WeakArea(
        topic: json['topic'] as String,
        score: (json['score'] as num).toDouble(),
        attempts: json['attempts'] as int,
      );

  Map<String, dynamic> toJson() => {
        'topic': topic,
        'score': score,
        'attempts': attempts,
      };
}
