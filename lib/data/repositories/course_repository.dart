import 'package:livemcq3/core/network/dio_client.dart';

class CourseRepository {
  final DioClient dioClient;

  CourseRepository(this.dioClient);

  Future<List<Map<String, dynamic>>> getCourses() async {
    final response = await dioClient.dio.get('/api/v1/courses');
    final data = response.data['data'] as List;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }

  Future<Map<String, dynamic>> getCourseDetail(String courseId) async {
    final response = await dioClient.dio.get('/api/v1/courses/$courseId');
    final data = response.data['data'] as Map<String, dynamic>;
    return data;
  }

  Future<Map<String, dynamic>> enrollCourse(String courseId) async {
    final response = await dioClient.dio.post('/api/v1/courses/$courseId/enroll');
    final data = response.data['data'] as Map<String, dynamic>;
    return data;
  }

  Future<List<Map<String, dynamic>>> getEnrollments() async {
    final response = await dioClient.dio.get('/api/v1/courses/enrollments');
    final data = response.data['data'] as List;
    return data.map((e) => e as Map<String, dynamic>).toList();
  }
}
