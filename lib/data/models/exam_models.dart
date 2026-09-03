class ExamCategoryModel {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final bool isPremium;
  final int? price;
  final int? subjectsCount;

  ExamCategoryModel({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.isPremium = false,
    this.price,
    this.subjectsCount,
  });

  factory ExamCategoryModel.fromJson(Map<String, dynamic> json) {
    return ExamCategoryModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'],
      icon: json['icon'],
      isPremium: json['is_premium'] ?? false,
      price: json['price'],
      subjectsCount: json['subjects_count'],
    );
  }
}

class SubjectModel {
  final int id;
  final String name;
  final int categoryId;
  final int? questionsCount;

  SubjectModel({
    required this.id,
    required this.name,
    required this.categoryId,
    this.questionsCount,
  });

  factory SubjectModel.fromJson(Map<String, dynamic> json) {
    return SubjectModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      categoryId: json['exam_category_id'] ?? json['category_id'] ?? 0,
      questionsCount: json['questions_count'],
    );
  }
}

class ChapterModel {
  final int id;
  final String name;
  final int subjectId;

  ChapterModel({
    required this.id,
    required this.name,
    required this.subjectId,
  });

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      subjectId: json['subject_id'] ?? 0,
    );
  }
}

class QuestionModel {
  final int id;
  final int examCategoryId;
  final int subjectId;
  final String text;
  final String? explanation;
  final String difficulty;
  final List<QuestionOptionModel> options;

  QuestionModel({
    required this.id,
    required this.examCategoryId,
    required this.subjectId,
    required this.text,
    this.explanation,
    this.difficulty = 'medium',
    this.options = const [],
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final rawOptions = json['options'] as List<dynamic>? ?? [];
    final options = rawOptions
        .map((e) => QuestionOptionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return QuestionModel(
      id: json['id'] ?? 0,
      examCategoryId: json['exam_category_id'] ?? 0,
      subjectId: json['subject_id'] ?? 0,
      text: json['text'] ?? '',
      explanation: json['explanation'],
      difficulty: json['difficulty'] ?? 'medium',
      options: options,
    );
  }
}

class QuestionOptionModel {
  final int id;
  final int questionId;
  final String text;
  final bool isCorrect;

  QuestionOptionModel({
    required this.id,
    required this.questionId,
    required this.text,
    this.isCorrect = false,
  });

  factory QuestionOptionModel.fromJson(Map<String, dynamic> json) {
    return QuestionOptionModel(
      id: json['id'] ?? 0,
      questionId: json['question_id'] ?? 0,
      text: json['text'] ?? '',
      isCorrect: json['is_correct'] ?? false,
    );
  }
}

class ExamSubmitResultModel {
  final int correct;
  final int wrong;
  final int total;
  final double score;
  final ExamSessionModel? session;

  ExamSubmitResultModel({
    required this.correct,
    required this.wrong,
    required this.total,
    required this.score,
    this.session,
  });

  factory ExamSubmitResultModel.fromJson(Map<String, dynamic> json) {
    return ExamSubmitResultModel(
      correct: json['correct'] ?? 0,
      wrong: json['wrong'] ?? 0,
      total: json['total'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
      session: json['session'] != null ? ExamSessionModel.fromJson(json['session'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'correct': correct,
      'wrong': wrong,
      'total': total,
      'score': score,
      'session': session?.toJson(),
    };
  }
}

class ExamSessionModel {
  final int id;
  final int userId;
  final int examCategoryId;
  final String type;
  final int totalQuestions;
  final int correctAnswers;
  final int wrongAnswers;
  final double score;

  ExamSessionModel({
    required this.id,
    required this.userId,
    required this.examCategoryId,
    required this.type,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.wrongAnswers,
    required this.score,
  });

  factory ExamSessionModel.fromJson(Map<String, dynamic> json) {
    return ExamSessionModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      examCategoryId: json['exam_category_id'] ?? 0,
      type: json['type'] ?? '',
      totalQuestions: json['total_questions'] ?? 0,
      correctAnswers: json['correct_answers'] ?? 0,
      wrongAnswers: json['wrong_answers'] ?? 0,
      score: (json['score'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'exam_category_id': examCategoryId,
      'type': type,
      'total_questions': totalQuestions,
      'correct_answers': correctAnswers,
      'wrong_answers': wrongAnswers,
      'score': score,
    };
  }
}

class BookmarkModel {
  final int id;
  final int userId;
  final int questionId;

  BookmarkModel({
    required this.id,
    required this.userId,
    required this.questionId,
  });

  factory BookmarkModel.fromJson(Map<String, dynamic> json) {
    return BookmarkModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      questionId: json['question_id'] ?? 0,
    );
  }
}
