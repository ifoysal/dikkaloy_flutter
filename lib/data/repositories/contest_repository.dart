import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/contest_models.dart';

class ContestRepository {
  final DioClient dioClient;

  ContestRepository(this.dioClient);

  Future<List<LiveContestModel>> getContests() async {
    final response = await dioClient.dio.get(ApiEndpoints.contests);
    final data = response.data['data'];
    if (data is Map<String, dynamic> && data.containsKey('data')) {
      final list = data['data'] as List;
      return list.map((e) => LiveContestModel.fromJson(e as Map<String, dynamic>)).toList();
    }
    final list = data as List;
    return list.map((e) => LiveContestModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<LiveContestModel> getContestDetail(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.contestDetail(id));
    final data = response.data['data'] as Map<String, dynamic>;
    return LiveContestModel.fromJson(data);
  }

  Future<List<ContestQuestionModel>> getContestQuestions(int contestId) async {
    final response = await dioClient.dio.get(ApiEndpoints.contestArena(contestId));
    final data = response.data['data'] as Map<String, dynamic>;
    final questions = data['questions'] as List? ?? [];
    return questions.map((e) => ContestQuestionModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> joinContest(int id) async {
    await dioClient.dio.post(ApiEndpoints.contestJoin(id));
  }

  Future<List<ContestLeaderboardEntryModel>> getLeaderboard(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.contestArena(id));
    final data = response.data['data'] as Map<String, dynamic>;
    final leaderboard = data['leaderboard'] as List? ?? [];
    return leaderboard.map((e) => ContestLeaderboardEntryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<Map<String, dynamic>> submitAnswer(int contestId, int questionId, int selectedOptionId) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.contestSubmit(contestId),
      data: {
        'question_id': questionId,
        'selected_option_id': selectedOptionId,
      },
    );
    return response.data['data'] as Map<String, dynamic>;
  }

  Future<Map<String, dynamic>> getContestResult(int contestId) async {
    final response = await dioClient.dio.get(ApiEndpoints.contestResult(contestId));
    return response.data['data'] as Map<String, dynamic>;
  }
}
