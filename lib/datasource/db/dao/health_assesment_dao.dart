import 'package:floor/floor.dart';

import '../../../models/health_assessment.dart';

@dao
abstract class HealthAssessmentDao {
  @Query('SELECT * FROM HealthAssessmentEntity')
  Future<List<HealthAssessmentEntity>> getAll();

  @insert
  Future<void> insertHealthAssessment(HealthAssessmentEntity entity);

  @Query('DELETE FROM HealthAssessmentEntity WHERE id = :id')
  Future<void> deleteHealthAssessment(String id);
}
