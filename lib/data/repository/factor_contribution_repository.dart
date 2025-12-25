import '../../models/health_assessment.dart';

abstract class FactorContributionRepository {
  Future<void> insertFactorContribution(List<FactorContribution> entity);
  Future<void> deleteByForeignKey(String foreignKey);
  Future<List<FactorContribution>> getAll(String foreignKey);
}
