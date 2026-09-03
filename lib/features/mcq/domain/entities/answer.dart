import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  final int questionId;
  final int selectedOptionId;

  const Answer({required this.questionId, required this.selectedOptionId});

  @override
  List<Object?> get props => [questionId, selectedOptionId];
}
