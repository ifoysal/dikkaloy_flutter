import 'package:equatable/equatable.dart';
import 'package:livemcq3/features/cv/domain/entities/cv.dart';

abstract class CvRepository {
  Future<List<Cv>> getCvs();
  Future<Cv> getCv(int id);
  Future<Cv> createCv(String title, String template);
  Future<Cv> updateCvSection(int id, String section, Map<String, dynamic> data);
  Future<Cv> duplicateCv(int id);
  Future<void> deleteCv(int id);
  Future<String> generatePdf(int id);
}
