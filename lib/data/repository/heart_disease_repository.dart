import '../../models/health_assessment.dart';
import '../../models/prediction_response.dart';


abstract class HeartDiseaseRepository {
  Future<PredictionResponse> getHeartDiseasePrediction(FormData formData);
}