"""Preprocessing utilities for heart disease prediction.

Handles feature extraction, ordering, and scaling.
"""

import numpy as np
from app.schemas.heart import HeartDiseaseInput


# CRITICAL: Feature order MUST match the training data order
# Do NOT change this order or predictions will be incorrect
FEATURE_ORDER = [
    'age', 
    'sex', 
    'cp', 
    'trestbps', 
    'chol', 
    'fbs', 
    'restecg', 
    'thalach', 
    'exang', 
    'oldpeak', 
    'slope', 
    'ca', 
    'thal'
]


def preprocess_input(data: HeartDiseaseInput, scaler) -> np.ndarray:
    """Preprocess input data for model prediction.
    
    Converts Pydantic model to numpy array in correct feature order,
    then applies scaling transformation.
    
    Args:
        data: Validated input data from request
        scaler: Pre-trained StandardScaler or MinMaxScaler
        
    Returns:
        Scaled feature array of shape (1, 13) ready for model prediction
        
    Raises:
        ValueError: If feature extraction fails
    """
    try:
        # Convert Pydantic model to dictionary
        data_dict = data.model_dump()
        
        # Extract features in EXACT training order
        features = [[data_dict[feature] for feature in FEATURE_ORDER]]
        
        # Convert to numpy array
        features_array = np.array(features, dtype=np.float64)
        
        # Apply scaling transformation
        scaled_features = scaler.transform(features_array)
        
        return scaled_features
        
    except KeyError as e:
        raise ValueError(f"Missing required feature: {e}")
    except Exception as e:
        raise ValueError(f"Preprocessing failed: {e}")


def validate_feature_order(features: list) -> bool:
    """Validate that features match expected order.
    
    Args:
        features: List of feature names to validate
        
    Returns:
        True if order matches exactly, False otherwise
    """
    return features == FEATURE_ORDER
