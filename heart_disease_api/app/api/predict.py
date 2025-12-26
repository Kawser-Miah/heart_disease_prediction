"""Prediction API endpoint.

Handles POST /predict requests for heart disease prediction.
"""

from fastapi import APIRouter, HTTPException, status
from app.schemas.heart import HeartDiseaseInput, HeartDiseasePrediction
from app.models.predictor import HeartDiseasePredictor

# Create API router
router = APIRouter()

# Initialize predictor (model loaded at module level)
predictor = HeartDiseasePredictor()


@router.post(
    "/predict",
    response_model=HeartDiseasePrediction,
    status_code=status.HTTP_200_OK,
    summary="Predict heart disease",
    description="Predict heart disease probability based on patient health metrics",
    responses={
        200: {
            "description": "Successful prediction",
            "content": {
                "application/json": {
                    "example": {
                        "prediction": True,
                        "probability": 0.8523,
                        "risk_level": "High"
                    }
                }
            }
        },
        422: {
            "description": "Validation error - invalid input data"
        },
        500: {
            "description": "Server error - prediction failed"
        }
    }
)
async def predict_heart_disease(data: HeartDiseaseInput):
    """Predict heart disease based on patient health data.
    
    Accepts 13 health metrics and returns:
    - Boolean prediction (true/false)
    - Probability score (0.0 to 1.0)
    - Risk level (Low/Medium/High)
    
    Args:
        data: Patient health metrics (validated by Pydantic)
        
    Returns:
        HeartDiseasePrediction with result
        
    Raises:
        HTTPException: If prediction fails
    """
    try:
        # Make prediction
        result = predictor.predict(data)
        return result
        
    except ValueError as e:
        # Handle preprocessing or prediction errors
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Prediction error: {str(e)}"
        )
    except Exception as e:
        # Handle unexpected errors
        raise HTTPException(
            status_code=status.HTTP_500_INTERNAL_SERVER_ERROR,
            detail=f"Unexpected error: {str(e)}"
        )
