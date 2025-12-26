"""Heart disease prediction logic.

Handles the core prediction workflow:
1. Preprocess input data
2. Apply ML model
3. Calculate probability
4. Determine risk level
5. Return structured result
"""

import numpy as np
from app.models import ml_model
from app.schemas.heart import HeartDiseaseInput, HeartDiseasePrediction
from app.utils.preprocessing import preprocess_input


class HeartDiseasePredictor:
    """Predictor class for heart disease detection.
    
    Uses pre-trained model and scaler loaded at module level.
    Applies risk thresholds to probability scores.
    """
    
    def __init__(self):
        """Initialize predictor with loaded model and scaler."""
        self.model = ml_model.get_model()
        self.scaler = ml_model.get_scaler()
    
    def predict(self, data: HeartDiseaseInput) -> HeartDiseasePrediction:
        """Make prediction for heart disease.
        
        Args:
            data: Validated patient health metrics
            
        Returns:
            HeartDiseasePrediction with prediction, probability, and risk level
            
        Raises:
            ValueError: If prediction fails
        """
        try:
            # Step 1: Preprocess input (scale features)
            features = preprocess_input(data, self.scaler)
            
            # Step 2: Get probability predictions
            # predict_proba returns array of shape (n_samples, n_classes)
            # For binary classification: [[prob_class_0, prob_class_1]]
            prediction_proba = self.model.predict_proba(features)[0]
            
            # Step 3: Extract probability of positive class (heart disease)
            probability = float(prediction_proba[1])
            
            # Step 4: Make binary prediction (0 or 1)
            prediction_class = int(self.model.predict(features)[0])
            
            # Step 5: Convert to boolean
            has_disease = bool(prediction_class == 1)
            
            # Step 6: Determine risk level based on probability thresholds
            risk_level = self._get_risk_level(probability)
            
            # Step 7: Return structured response
            return HeartDiseasePrediction(
                prediction=has_disease,
                probability=round(probability, 4),
                risk_level=risk_level
            )
            
        except Exception as e:
            raise ValueError(f"Prediction failed: {str(e)}")
    
    def _get_risk_level(self, probability: float) -> str:
        """Categorize risk level based on probability threshold.
        
        Thresholds:
        - >= 0.7: High Risk
        - >= 0.4: Medium Risk  
        - < 0.4: Low Risk
        
        Args:
            probability: Predicted probability of heart disease (0.0 to 1.0)
            
        Returns:
            Risk level string: "High", "Medium", or "Low"
        """
        if probability >= 0.7:
            return "High"
        elif probability >= 0.4:
            return "Medium"
        else:
            return "Low"
