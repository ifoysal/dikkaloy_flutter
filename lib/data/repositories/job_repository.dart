import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/job_models.dart';

class JobRepository {
  final DioClient dioClient;

  JobRepository(this.dioClient);

  Future<List<JobCircularModel>> getJobs({String? search, int? categoryId, String? location}) async {
    final response = await dioClient.dio.get(
      ApiEndpoints.jobs,
      queryParameters: {
        if (search != null && search.isNotEmpty) 'search': search,
        if (categoryId != null) 'category_id': categoryId,
        if (location != null && location.isNotEmpty) 'location': location,
      },
    );
    final data = response.data['data'] as List;
    return data.map((e) => JobCircularModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<JobCircularModel> getJobDetail(int jobId) async {
    final response = await dioClient.dio.get(ApiEndpoints.jobDetail(jobId));
    final data = response.data['data'] as Map<String, dynamic>;
    return JobCircularModel.fromJson(data);
  }

  Future<List<JobCategoryModel>> getJobCategories() async {
    final response = await dioClient.dio.get(ApiEndpoints.jobCategories);
    final data = response.data['data'] as List;
    return data.map((e) => JobCategoryModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<void> saveJob(int jobId) async {
    await dioClient.dio.post(ApiEndpoints.jobSave(jobId));
  }

  Future<void> unsaveJob(int jobId) async {
    await dioClient.dio.delete(ApiEndpoints.jobUnsave(jobId));
  }

  Future<List<SavedJobModel>> getSavedJobs() async {
    final response = await dioClient.dio.get(ApiEndpoints.savedJobs);
    final data = response.data['data'] as List;
    return data.map((e) => SavedJobModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<JobAlertModel>> getJobAlerts() async {
    final response = await dioClient.dio.get(ApiEndpoints.jobAlerts);
    final data = response.data['data'] as List;
    return data.map((e) => JobAlertModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<JobAlertModel> createJobAlert({required String keyword, int? categoryId}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.jobAlerts,
      data: {
        'keyword': keyword,
        if (categoryId != null) 'category_id': categoryId,
      },
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return JobAlertModel.fromJson(data);
  }

  Future<void> deleteJobAlert(int alertId) async {
    await dioClient.dio.delete(ApiEndpoints.jobAlertDetail(alertId));
  }
}
