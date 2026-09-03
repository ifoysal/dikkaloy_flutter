import 'package:equatable/equatable.dart';

class UpcomingContest extends Equatable {
  final int id;
  final String title;
  final String startAt;
  final int participantsCount;

  const UpcomingContest({
    required this.id,
    required this.title,
    required this.startAt,
    required this.participantsCount,
  });

  @override
  List<Object?> get props => [id, title, startAt, participantsCount];
}
