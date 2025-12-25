import 'package:dio/dio.dart' hide FormData;
import 'package:heart_disease_prediction/models/health_assessment.dart';

import '../../datasource/datafrom_remote_source.dart';
import '../../models/prediction_response.dart';
import '../repository/heart_disease_repository.dart';

class HeartDiseaseRepositoryIml extends HeartDiseaseRepository {
  @override
  Future<PredictionResponse> getHeartDiseasePrediction(
    FormData formData,
  ) async {
    try {
      final result = await DataFromRemoteSource(
        Dio(),
      ).predict(formData: formData);

      return result;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
