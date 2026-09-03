import 'package:dio/dio.dart';
import 'package:livemcq3/core/constants/api_constants.dart';
import 'package:livemcq3/features/cv/domain/entities/cv.dart';
import 'package:livemcq3/features/cv/domain/repositories/cv_repository.dart';

class CvRepositoryImpl implements CvRepository {
  final Dio dio;
  CvRepositoryImpl(this.dio);

  @override
  Future<List<Cv>> getCvs() async {
    final response = await dio.get(ApiConstants.cvs());
    final list = response.data['data'] as List<dynamic>;
    return list.whereType<Map<String, dynamic>>().map((c) => Cv(
          id: c['id'] as int,
          title: c['title'] as String,
          template: c['template'] as String,
          sections: c['sections'] as Map<String, dynamic>,
          pdfUrl: c['pdf_url'] as String?,
        )).toList();
  }

  @override
  Future<Cv> getCv(int id) async {
    final response = await dio.get(ApiConstants.cv(id));
    final c = response.data['data'] as Map<String, dynamic>;
    return Cv(
      id: c['id'] as int,
      title: c['title'] as String,
      template: c['template'] as String,
      sections: c['sections'] as Map<String, dynamic>,
      pdfUrl: c['pdf_url'] as String?,
    );
  }

  @override
  Future<Cv> createCv(String title, String template) async {
    final response = await dio.post(ApiConstants.cvs(), data: {'title': title, 'template': template});
    final c = response.data['data'] as Map<String, dynamic>;
    return Cv(
      id: c['id'] as int,
      title: c['title'] as String,
      template: c['template'] as String,
      sections: c['sections'] as Map<String, dynamic>,
      pdfUrl: c['pdf_url'] as String?,
    );
  }

  @override
  Future<Cv> updateCvSection(int id, String section, Map<String, dynamic> data) async {
    final response = await dio.put(ApiConstants.cvSection(id, section), data: data);
    final c = response.data['data'] as Map<String, dynamic>;
    return Cv(
      id: c['id'] as int,
      title: c['title'] as String,
      template: c['template'] as String,
      sections: c['sections'] as Map<String, dynamic>,
      pdfUrl: c['pdf_url'] as String?,
    );
  }

  @override
  Future<Cv> duplicateCv(int id) async {
    final response = await dio.post(ApiConstants.cvDuplicate(id));
    final c = response.data['data'] as Map<String, dynamic>;
    return Cv(
      id: c['id'] as int,
      title: c['title'] as String,
      template: c['template'] as String,
      sections: c['sections'] as Map<String, dynamic>,
      pdfUrl: c['pdf_url'] as String?,
    );
  }

  @override
  Future<void> deleteCv(int id) async {
    await dio.delete(ApiConstants.cv(id));
  }

  @override
  Future<String> generatePdf(int id) async {
    final response = await dio.get(ApiConstants.cvPdf(id));
    return response.data['data']['url'] as String;
  }
}
