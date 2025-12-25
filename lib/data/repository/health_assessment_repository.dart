import '../../models/health_assessment.dart';

abstract class HealthAssessmentRepository {
  Future<void> insertHealthAssessment(HealthAssessmentEntity entity);
  Future<void> deleteHealthAssessment(String id);
  Future<List<HealthAssessmentEntity>> getAll();
}
