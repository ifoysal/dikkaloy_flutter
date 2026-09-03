import 'package:equatable/equatable.dart';

class RecentJob extends Equatable {
  final int id;
  final String title;
  final String company;
  final String location;

  const RecentJob({
    required this.id,
    required this.title,
    required this.company,
    required this.location,
  });

  @override
  List<Object?> get props => [id, title, company, location];
}
