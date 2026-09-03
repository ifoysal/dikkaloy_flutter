import 'package:equatable/equatable.dart';

class ContinueReading extends Equatable {
  final int id;
  final String title;
  final String cover;
  final double progress;

  const ContinueReading({
    required this.id,
    required this.title,
    required this.cover,
    required this.progress,
  });

  @override
  List<Object?> get props => [id, title, cover, progress];
}
