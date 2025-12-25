/// prediction : false
/// probability : 0.45
/// risk_level : "Medium"

class PredictionResponse {
  PredictionResponse({
      bool? prediction, 
      double? probability, 
      String? riskLevel,}){
    _prediction = prediction;
    _probability = probability;
    _riskLevel = riskLevel;
}

  PredictionResponse.fromJson(dynamic json) {
    _prediction = json['prediction'];
    _probability = json['probability'];
    _riskLevel = json['risk_level'];
  }
  bool? _prediction;
  double? _probability;
  String? _riskLevel;
PredictionResponse copyWith({  bool? prediction,
  double? probability,
  String? riskLevel,
}) => PredictionResponse(  prediction: prediction ?? _prediction,
  probability: probability ?? _probability,
  riskLevel: riskLevel ?? _riskLevel,
);
  bool? get prediction => _prediction;
  double? get probability => _probability;
  String? get riskLevel => _riskLevel;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['prediction'] = _prediction;
    map['probability'] = _probability;
    map['risk_level'] = _riskLevel;
    return map;
  }

}