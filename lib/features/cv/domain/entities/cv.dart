import 'package:equatable/equatable.dart';

class Cv extends Equatable {
  final int id;
  final String title;
  final String template;
  final Map<String, dynamic> sections;
  final String? pdfUrl;

  const Cv({required this.id, required this.title, required this.template, required this.sections, this.pdfUrl});

  @override
  List<Object?> get props => [id, title, template, sections, pdfUrl];
}
