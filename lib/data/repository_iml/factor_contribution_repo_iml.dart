import 'package:heart_disease_prediction/models/health_assessment.dart';

import '../../datasource/db/heart_disease_db.dart';
import '../repository/factor_contribution_repository.dart';

class FactorContributionRepoIml extends FactorContributionRepository {
  HeartDiseaseDb db;
  FactorContributionRepoIml(this.db);

  @override
  Future<List<FactorContribution>> getAll(String foreignKey) async {
    try {
      final result = await db.factorContributionDao.getAll(foreignKey);

      return result;
    } catch (e) {
      throw Exception("Error getting all factor contributions: $e");
    }
  }

  @override
  Future<void> insertFactorContribution(List<FactorContribution> entity) async {
    try {
      await db.factorContributionDao.insertFactorContribution(entity);
    } catch (e) {
      throw Exception("Error inserting factor contribution: $e");
    }
  }

  @override
  Future<void> deleteByForeignKey(String foreignKey) {
    try {
      return db.factorContributionDao.deleteByForeignKey(foreignKey);
    } catch (e) {
      throw Exception("Error deleting factor contribution: $e");
    }
  }
}
