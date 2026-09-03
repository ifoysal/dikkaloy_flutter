import 'package:livemcq3/features/cv/domain/entities/cv.dart';
import 'package:livemcq3/features/cv/domain/repositories/cv_repository.dart';

class CreateCv {
  final CvRepository repository;
  CreateCv(this.repository);
  Future<Cv> call(String title, String template) => repository.createCv(title, template);
}

class DuplicateCv {
  final CvRepository repository;
  DuplicateCv(this.repository);
  Future<Cv> call(int id) => repository.duplicateCv(id);
}

class GeneratePdf {
  final CvRepository repository;
  GeneratePdf(this.repository);
  Future<String> call(int id) => repository.generatePdf(id);
}
