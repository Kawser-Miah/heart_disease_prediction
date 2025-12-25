import 'package:floor/floor.dart';

import '../../../models/health_assessment.dart';

@dao
abstract class FactorContributionDao {
  @Query('SELECT * FROM FactorContribution WHERE foreignKey = :foreignKey')
  Future<List<FactorContribution>> getAll(String foreignKey);

  @insert
  Future<void> insertFactorContribution(List<FactorContribution> entity);

  @Query('DELETE FROM FactorContribution WHERE foreignKey = :foreignKey')
  Future<void> deleteByForeignKey(String foreignKey);
}
