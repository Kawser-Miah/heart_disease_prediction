import 'package:equatable/equatable.dart';
import '../models/health_assessment.dart';

abstract class AssessmentState extends Equatable {
  const AssessmentState();

  @override
  List<Object?> get props => [];
}

class AssessmentInitial extends AssessmentState {
  const AssessmentInitial();
}

class AssessmentFormInProgress extends AssessmentState {
  final FormData formData;

  const AssessmentFormInProgress(this.formData);

  @override
  List<Object?> get props => [formData];
}

class AssessmentAnalyzing extends AssessmentState {
  final FormData formData;

  const AssessmentAnalyzing(this.formData);

  @override
  List<Object?> get props => [formData];
}

class AssessmentCompleted extends AssessmentState {
  final HealthAssessment assessment;

  const AssessmentCompleted(this.assessment);

  @override
  List<Object?> get props => [assessment];
}

class AssessmentHistoryLoaded extends AssessmentState {
  final List<HealthAssessment> assessments;
  final HealthAssessment? currentAssessment;

  const AssessmentHistoryLoaded({
    required this.assessments,
    this.currentAssessment,
  });

  @override
  List<Object?> get props => [assessments, currentAssessment];
}

class AssessmentError extends AssessmentState {
  final String message;

  const AssessmentError(this.message);

  @override
  List<Object?> get props => [message];
}

class AssessmentLoading extends AssessmentState {
  const AssessmentLoading();
}


