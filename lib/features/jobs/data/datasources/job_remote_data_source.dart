import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/jobs/domain/entities/job.dart';

class JobRemoteDataSource {
  final Dio dio;
  JobRemoteDataSource(this.dio);

  Future<List<dynamic>> fetchJobs() async {
    final response = await dio.get(ApiConstants.jobs());
    return response.data['data'] as List<dynamic>;
  }

  Future<Map<String, dynamic>> fetchJob(int id) async {
    final response = await dio.get(ApiConstants.job(id));
    return response.data['data'] as Map<String, dynamic>;
  }
}
