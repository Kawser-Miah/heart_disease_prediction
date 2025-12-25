import 'package:heart_disease_prediction/data/repository/health_assessment_repository.dart';
import 'package:heart_disease_prediction/models/health_assessment.dart';

import '../../datasource/db/heart_disease_db.dart';

class HealthAssessmentRepoIml extends HealthAssessmentRepository {
  HeartDiseaseDb db;
  HealthAssessmentRepoIml(this.db);

  @override
  Future<void> deleteHealthAssessment(String id) async {
    try {
      await db.healthAssessmentDao.deleteHealthAssessment(id);
    } catch (e) {
      throw Exception("Error deleting health assessment: $e");
    }
  }

  @override
  Future<List<HealthAssessmentEntity>> getAll() async {
    try {
      final result = await db.healthAssessmentDao.getAll();
      if (result.isNotEmpty) {
        return result;
      } else {
        throw Exception("No health assessments found");
      }
    } catch (e) {
      throw Exception("Error getting all health assessments: $e");
    }
  }

  @override
  Future<void> insertHealthAssessment(HealthAssessmentEntity entity) async {
    try {
      await db.healthAssessmentDao.insertHealthAssessment(entity);
    } catch (e) {
      throw Exception("Error inserting health assessment: $e");
    }
  }
}
