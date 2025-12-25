import 'package:equatable/equatable.dart';
import '../models/health_assessment.dart';

abstract class AssessmentEvent extends Equatable {
  const AssessmentEvent();

  @override
  List<Object?> get props => [];
}

class UpdateFormField extends AssessmentEvent {
  final FormData formData;

  const UpdateFormField(this.formData);

  @override
  List<Object?> get props => [formData];
}

class SubmitAssessment extends AssessmentEvent {
  final FormData formData;

  const SubmitAssessment(this.formData);

  @override
  List<Object?> get props => [formData];
}

class LoadAssessmentHistory extends AssessmentEvent {
  const LoadAssessmentHistory();
}

class ClearCurrentAssessment extends AssessmentEvent {
  const ClearCurrentAssessment();
}

class DeleteAssessment extends AssessmentEvent {
  final String assessmentId;

  const DeleteAssessment(this.assessmentId);

  @override
  List<Object?> get props => [assessmentId];
}
