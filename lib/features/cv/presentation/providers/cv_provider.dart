import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:livemcq3/features/cv/domain/usecases/create_cv.dart';
part 'cv_provider.g.dart';

final createCvProvider = Provider<CreateCv>((ref) => CreateCv(ref.read(cvRepositoryProvider)));
final duplicateCvProvider = Provider<DuplicateCv>((ref) => DuplicateCv(ref.read(cvRepositoryProvider)));
final generatePdfProvider = Provider<GeneratePdf>((ref) => GeneratePdf(ref.read(cvRepositoryProvider)));
