import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/cv_models.dart';

class CvRepository {
  final DioClient dioClient;

  CvRepository(this.dioClient);

  Future<List<CvTemplateModel>> getTemplates() async {
    final response = await dioClient.dio.get(ApiEndpoints.cvTemplates);
    final data = response.data['data'] as List;
    return data.map((e) => CvTemplateModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<CvModel>> getCvs() async {
    final response = await dioClient.dio.get(ApiEndpoints.cvs);
    final data = response.data['data'] as List;
    return data.map((e) => CvModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<CvModel> createCv({required int templateId, required String title, String style = 'cv'}) async {
    final response = await dioClient.dio.post(
      ApiEndpoints.cvs,
      data: {'template_id': templateId, 'title': title, 'style': style},
    );
    final data = response.data['data'] as Map<String, dynamic>;
    return CvModel.fromJson(data);
  }

  Future<CvModel> updateCv(int id, Map<String, dynamic> updates) async {
    final response = await dioClient.dio.put(ApiEndpoints.cvDetail(id), data: updates);
    final data = response.data['data'] as Map<String, dynamic>;
    return CvModel.fromJson(data);
  }

  Future<void> deleteCv(int id) async {
    await dioClient.dio.delete(ApiEndpoints.cvDetail(id));
  }

  Future<void> duplicateCv(int id) async {
    await dioClient.dio.post(ApiEndpoints.cvDuplicate(id));
  }

  Future<String> getPdfUrl(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.cvPdf(id));
    final data = response.data['data'] as Map<String, dynamic>?;
    return data?['url']?.toString() ?? '';
  }
}
