import 'package:equatable/equatable.dart';

class DashboardStats extends Equatable {
  final int examsCompleted;
  final double averageScore;
  final int savedJobsCount;
  final int purchasedBooksCount;

  const DashboardStats({
    required this.examsCompleted,
    required this.averageScore,
    required this.savedJobsCount,
    required this.purchasedBooksCount,
  });

  @override
  List<Object?> get props => [examsCompleted, averageScore, savedJobsCount, purchasedBooksCount];
}
