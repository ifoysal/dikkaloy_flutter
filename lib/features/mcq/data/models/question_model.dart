import 'package:json_annotation/json_annotation.dart';
import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';

part 'question_model.g.dart';

@JsonSerializable()
class QuestionModel extends Equatable {
  final int id;
  final String text;
  final List<String> options;
  @JsonKey(name: 'correct_index')
  final int correctIndex;
  @JsonKey(name: 'type')
  final String type;
  final String? explanation;
  @JsonKey(name: 'chapter_id')
  final int? chapterId;
  @JsonKey(name: 'chapter_name')
  final String? chapterName;

  const QuestionModel({
    required this.id,
    required this.text,
    required this.options,
    required this.correctIndex,
    required this.type,
    this.explanation,
    this.chapterId,
    this.chapterName,
  });

  @override
  List<Object?> get props => [id, text, options, correctIndex, type, explanation, chapterId, chapterName];

  factory QuestionModel.fromJson(Map<String, dynamic> json) => _$QuestionModelFromJson(json);
  Map<String, dynamic> toJson() => _$QuestionModelToJson(this);

  Question toEntity() {
    final questionType = type == 'true_false' ? QuestionType.true_false : type == 'fill_blank' ? QuestionType.fill_blank : QuestionType.mcq;
    final optionList = <QuestionOption>[];
    for (var i = 0; i < options.length; i++) {
      optionList.add(QuestionOption(id: i + 1, text: options[i], isCorrect: i == correctIndex));
    }
    return Question(
      id: id,
      text: text,
      options: optionList,
      type: questionType,
      explanation: explanation,
      chapterId: chapterId,
      chapterName: chapterName,
    );
  }
}
