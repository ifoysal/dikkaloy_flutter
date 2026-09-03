import 'package:livemcq3/features/mcq/data/models/question_model.dart';
import 'package:livemcq3/features/mcq/domain/entities/question.dart';

class QuestionMapper {
  static Question fromModel(QuestionModel model) => Question(
        id: model.id,
        text: model.text,
        options: model.options.map((text) => QuestionOption(id: 0, text: text)).toList(),
        type: QuestionType.values.firstWhere((t) => t.name == model.type, orElse: () => QuestionType.mcq),
        explanation: model.explanation,
        chapterId: model.chapterId,
        chapterName: model.chapterName,
      );

  static QuestionModel toModel(Question entity) => QuestionModel(
        id: entity.id,
        text: entity.text,
        options: entity.options.map((o) => o.text).toList(),
        correctIndex: 0,
        type: entity.type.name,
        explanation: entity.explanation,
        chapterId: entity.chapterId,
        chapterName: entity.chapterName,
      );
}
