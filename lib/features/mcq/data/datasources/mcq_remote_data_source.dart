import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';

class McqRemoteDataSource {
  final Dio dio;
  McqRemoteDataSource(this.dio);

  Future<List<dynamic>> fetchCategories() async {
    final response = await dio.get(ApiConstants.categories);
    return response.data['data'] as List<dynamic>;
  }

  Future<List<dynamic>> fetchQuestions(int categoryId) async {
    final response = await dio.get(ApiConstants.categoryQuestions(categoryId));
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> submitExam(int categoryId, List<Map<String, dynamic>> answers) async {
    final response = await dio.post(ApiConstants.submitExam(categoryId), data: {'answers': answers});
    return response.data['data'] as Map<String, dynamic>;
  }
}
