import 'package:livemcq3/core/constants/endpoints.dart';
import 'package:livemcq3/core/network/dio_client.dart';
import 'package:livemcq3/data/models/syllabus_models.dart';

class SyllabusRepository {
  final DioClient dioClient;

  SyllabusRepository(this.dioClient);

  Future<List<SyllabusItemModel>> getSyllabus() async {
    final response = await dioClient.dio.get(ApiEndpoints.syllabuses);
    final data = response.data['data'] as List;
    return data.map((e) => SyllabusItemModel.fromJson(e as Map<String, dynamic>)).toList();
  }

  Future<SyllabusDetailModel> getSyllabusDetail(String categoryId) async {
    final response = await dioClient.dio.get(ApiEndpoints.syllabuses);
    final data = response.data['data'] as Map<String, dynamic>;
    return SyllabusDetailModel.fromJson(data);
  }
}
