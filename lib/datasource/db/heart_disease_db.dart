import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import '../../models/health_assessment.dart';
import 'dao/factor_contribution_dao.dart';
import 'dao/health_assesment_dao.dart';

part 'heart_disease_db.g.dart';

@Database(version: 1, entities: [HealthAssessmentEntity, FactorContribution])
abstract class HeartDiseaseDb extends FloorDatabase {
  HealthAssessmentDao get healthAssessmentDao;
  FactorContributionDao get factorContributionDao;
}
