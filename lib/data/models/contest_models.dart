bool? _toBool(dynamic value) {
  if (value is bool) return value;
  if (value is int) return value != 0;
  if (value is String) return value.toLowerCase() == 'true' || value == '1';
  return null;
}

class LiveContestModel {
  final int id;
  final String title;
  final String? description;
  final String startTime;
  final String endTime;
  final bool isActive;
  final bool isPremium;
  final int? price;
  final bool hasJoined;
  final bool hasAccess;

  LiveContestModel({
    required this.id,
    required this.title,
    this.description,
    required this.startTime,
    required this.endTime,
    this.isActive = true,
    this.isPremium = false,
    this.price,
    this.hasJoined = false,
    this.hasAccess = false,
  });

  factory LiveContestModel.fromJson(Map<String, dynamic> json) {
    return LiveContestModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'],
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      isActive: _toBool(json['is_active']) ?? true,
      isPremium: _toBool(json['is_premium']) ?? false,
      price: json['price'],
      hasJoined: _toBool(json['has_joined']) ?? false,
      hasAccess: _toBool(json['has_access']) ?? false,
    );
  }
}

class ContestLeaderboardEntryModel {
  final String name;
  final int score;

  ContestLeaderboardEntryModel({required this.name, required this.score});

  factory ContestLeaderboardEntryModel.fromJson(Map<String, dynamic> json) {
    return ContestLeaderboardEntryModel(
      name: json['name'] ?? '',
      score: json['score'] ?? 0,
    );
  }
}

class ContestQuestionModel {
  final int id;
  final String text;
  final String? explanation;
  final String difficulty;
  final List<ContestOptionModel> options;

  ContestQuestionModel({
    required this.id,
    required this.text,
    this.explanation,
    this.difficulty = 'medium',
    this.options = const [],
  });

  factory ContestQuestionModel.fromJson(Map<String, dynamic> json) {
    final options = (json['options'] as List<dynamic>? ?? [])
        .map((e) => ContestOptionModel.fromJson(e as Map<String, dynamic>))
        .toList();
    return ContestQuestionModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
      explanation: json['explanation'],
      difficulty: json['difficulty'] ?? 'medium',
      options: options,
    );
  }
}

class ContestOptionModel {
  final int id;
  final String text;

  ContestOptionModel({required this.id, required this.text});

  factory ContestOptionModel.fromJson(Map<String, dynamic> json) {
    return ContestOptionModel(
      id: json['id'] ?? 0,
      text: json['text'] ?? '',
    );
  }
}

class ContestResultModel {
  final int id;
  final int liveContestId;
  final int userId;
  final int score;
  final String? finishedAt;
  final int rank;
  final double percentile;
  final int totalParticipants;

  ContestResultModel({
    required this.id,
    required this.liveContestId,
    required this.userId,
    required this.score,
    this.finishedAt,
    this.rank = 0,
    this.percentile = 0,
    this.totalParticipants = 0,
  });

  factory ContestResultModel.fromJson(Map<String, dynamic> json) {
    return ContestResultModel(
      id: json['id'] ?? 0,
      liveContestId: json['live_contest_id'] ?? 0,
      userId: json['user_id'] ?? 0,
      score: json['score'] ?? 0,
      finishedAt: json['finished_at']?.toString(),
      rank: json['rank'] ?? 0,
      percentile: (json['percentile'] ?? 0).toDouble(),
      totalParticipants: json['total_participants'] ?? 0,
    );
  }
}
