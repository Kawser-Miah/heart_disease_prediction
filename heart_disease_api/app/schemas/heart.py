"""Pydantic schemas for heart disease prediction API.

Defines request and response models with validation.
"""

from pydantic import BaseModel, Field
from typing import Literal


class HeartDiseaseInput(BaseModel):
    """Input schema for heart disease prediction.
    
    All fields must be provided in the exact order specified.
    This order matches the training data feature order.
    """
    
    age: int = Field(
        ..., 
        ge=1, 
        le=120, 
        description="Age in years"
    )
    sex: int = Field(
        ..., 
        ge=0, 
        le=1, 
        description="Sex (0 = female, 1 = male)"
    )
    cp: int = Field(
        ..., 
        ge=0, 
        le=3, 
        description="Chest pain type (0-3)"
    )
    trestbps: int = Field(
        ..., 
        ge=50, 
        le=250, 
        description="Resting blood pressure (mm Hg)"
    )
    chol: int = Field(
        ..., 
        ge=100, 
        le=600, 
        description="Serum cholesterol (mg/dl)"
    )
    fbs: int = Field(
        ..., 
        ge=0, 
        le=1, 
        description="Fasting blood sugar > 120 mg/dl (0 = false, 1 = true)"
    )
    restecg: int = Field(
        ..., 
        ge=0, 
        le=2, 
        description="Resting electrocardiographic results (0-2)"
    )
    thalach: int = Field(
        ..., 
        ge=50, 
        le=250, 
        description="Maximum heart rate achieved"
    )
    exang: int = Field(
        ..., 
        ge=0, 
        le=1, 
        description="Exercise induced angina (0 = no, 1 = yes)"
    )
    oldpeak: float = Field(
        ..., 
        ge=0, 
        le=10, 
        description="ST depression induced by exercise relative to rest"
    )
    slope: int = Field(
        ..., 
        ge=0, 
        le=2, 
        description="Slope of the peak exercise ST segment (0-2)"
    )
    ca: int = Field(
        ..., 
        ge=0, 
        le=4, 
        description="Number of major vessels colored by fluoroscopy (0-4)"
    )
    thal: int = Field(
        ..., 
        ge=0, 
        le=3, 
        description="Thalassemia (0 = normal, 1 = fixed defect, 2 = reversible defect, 3 = unknown)"
    )
    
    class Config:
        json_schema_extra = {
            "example": {
                "age": 63,
                "sex": 1,
                "cp": 3,
                "trestbps": 145,
                "chol": 233,
                "fbs": 1,
                "restecg": 0,
                "thalach": 150,
                "exang": 0,
                "oldpeak": 2.3,
                "slope": 0,
                "ca": 0,
                "thal": 1
            }
        }


class HeartDiseasePrediction(BaseModel):
    """Output schema for heart disease prediction.
    
    Returns the prediction result with probability and risk assessment.
    """
    
    prediction: bool = Field(
        ..., 
        description="Prediction result (true = has heart disease, false = no heart disease)"
    )
    probability: float = Field(
        ..., 
        ge=0, 
        le=1, 
        description="Probability of having heart disease (0.0 to 1.0)"
    )
    risk_level: Literal["Low", "Medium", "High"] = Field(
        ..., 
        description="Risk level based on probability (Low / Medium / High)"
    )
    
    class Config:
        json_schema_extra = {
            "example": {
                "prediction": True,
                "probability": 0.85,
                "risk_level": "High"
            }
        }
