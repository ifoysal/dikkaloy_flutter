import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:livemcq3/core/providers/app_providers.dart';
import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';

class CvTemplateModel {
  final int id;
  final String name;
  final String bladeView;
  final String? previewImage;

  CvTemplateModel({
    required this.id,
    required this.name,
    required this.bladeView,
    this.previewImage,
  });

  factory CvTemplateModel.fromJson(Map<String, dynamic> json) {
    return CvTemplateModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      bladeView: json['blade_view'] ?? '',
      previewImage: json['preview_image'],
    );
  }
}

class UserCvModel {
  final int id;
  final int? templateId;
  final String title;
  final String style;
  final String status;
  final bool isDefault;
  final CvTemplateModel? template;
  final String createdAt;

  UserCvModel({
    required this.id,
    this.templateId,
    required this.title,
    required this.style,
    required this.status,
    required this.isDefault,
    this.template,
    required this.createdAt,
  });

  factory UserCvModel.fromJson(Map<String, dynamic> json) {
    return UserCvModel(
      id: json['id'] ?? 0,
      templateId: json['template_id'],
      title: json['title'] ?? '',
      style: json['style'] ?? 'cv',
      status: json['status'] ?? 'draft',
      isDefault: json['is_default'] == true || json['is_default'] == 1,
      template: json['template'] != null ? CvTemplateModel.fromJson(json['template']) : null,
      createdAt: json['created_at'] ?? '',
    );
  }
}

final cvRepositoryProvider = Provider<CvRepository>((ref) {
  return CvRepository(ref.watch(dioClientProvider));
});

final cvTemplatesProvider = FutureProvider<List<CvTemplateModel>>((ref) async {
  final repo = ref.watch(cvRepositoryProvider);
  return repo.getTemplates();
});

final userCvsProvider = FutureProvider<List<UserCvModel>>((ref) async {
  final repo = ref.watch(cvRepositoryProvider);
  return repo.getUserCvs();
});

class CvRepository {
  final DioClient dioClient;

  CvRepository(this.dioClient);

  Future<List<CvTemplateModel>> getTemplates() async {
    final response = await dioClient.dio.get(ApiEndpoints.cvTemplates);
    final data = response.data['data'] as List;
    return data.map((e) => CvTemplateModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<List<UserCvModel>> getUserCvs() async {
    final response = await dioClient.dio.get(ApiEndpoints.cvs);
    final data = response.data['data'] as List;
    return data.map((e) => UserCvModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<UserCvModel> createCv({required int templateId, required String title, String style = 'cv'}) async {
    final response = await dioClient.dio.post(ApiEndpoints.cvs, data: {
      'template_id': templateId,
      'title': title,
      'style': style,
    });
    return UserCvModel.fromJson(response.data['data']);
  }

  Future<UserCvModel> duplicateCv(int id) async {
    final response = await dioClient.dio.post(ApiEndpoints.cvDuplicate(id));
    return UserCvModel.fromJson(response.data['data']);
  }

  Future<void> deleteCv(int id) async {
    await dioClient.dio.delete(ApiEndpoints.cvDetail(id));
  }

  Future<String> getPdfUrl(int id) async {
    final response = await dioClient.dio.get(ApiEndpoints.cvPdf(id));
    return response.data['data']['download_url'] ?? '';
  }
}
