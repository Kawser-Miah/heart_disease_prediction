import 'package:dio/dio.dart' hide FormData;

import '../models/health_assessment.dart';
import '../models/prediction_response.dart';

class DataFromRemoteSource {
  final Dio _dio;

  DataFromRemoteSource(this._dio);

  Future<PredictionResponse> predict({required FormData formData}) async {
    try {
      final response = await _dio.post(
        'http://192.168.0.123:8000/api/predict',
        data: formData.toJson(),
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 200) {
        return PredictionResponse.fromJson(response.data);
      } else {
        throw Exception('Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data ?? 'Prediction request failed');
    }
  }
}
