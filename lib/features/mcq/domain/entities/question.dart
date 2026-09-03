import 'package:equatable/equatable.dart';

enum QuestionType { mcq, true_false, fill_blank }

class QuestionOption extends Equatable {
  final int id;
  final String text;
  final bool isCorrect;

  const QuestionOption({
    required this.id,
    required this.text,
    this.isCorrect = false,
  });

  @override
  List<Object?> get props => [id, text, isCorrect];

  Map<String, dynamic> toJson() => {'id': id, 'text': text, 'isCorrect': isCorrect};
  factory QuestionOption.fromJson(Map<String, dynamic> json) => QuestionOption(
        id: json['id'] as int,
        text: json['text'] as String,
        isCorrect: json['isCorrect'] as bool? ?? false,
      );
}

class Question extends Equatable {
  final int id;
  final String text;
  final List<QuestionOption> options;
  final QuestionType type;
  final String? explanation;
  final int? chapterId;
  final String? chapterName;

  const Question({
    required this.id,
    required this.text,
    required this.options,
    required this.type,
    this.explanation,
    this.chapterId,
    this.chapterName,
  });

  @override
  List<Object?> get props => [id, text, options, type, explanation, chapterId, chapterName];

  Map<String, dynamic> toJson() => {
        'id': id,
        'text': text,
        'options': options.map((o) => o.toJson()).toList(),
        'type': type.name,
        'explanation': explanation,
        'chapterId': chapterId,
        'chapterName': chapterName,
      };

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json['id'] as int,
        text: json['text'] as String,
        options: (json['options'] as List<dynamic>).map((o) => QuestionOption.fromJson(o as Map<String, dynamic>)).toList(),
        type: QuestionType.values.firstWhere((t) => t.name == json['type'] as String, orElse: () => QuestionType.mcq),
        explanation: json['explanation'] as String?,
        chapterId: json['chapterId'] as int?,
        chapterName: json['chapterName'] as String?,
      );
}
