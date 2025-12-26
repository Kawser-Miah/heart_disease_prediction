"""Machine learning model loader.

Loads pre-trained model and scaler at module level (once on startup).
Uses joblib for loading pickle files.
"""

import joblib
import warnings
from pathlib import Path
from app.core.config import settings

# Suppress sklearn version warnings
warnings.filterwarnings('ignore', category=UserWarning, module='sklearn')

# Module-level variables (loaded once)
_model = None
_scaler = None


def _load_artifacts():
    """Load model and scaler artifacts.
    
    Called once at module import time.
    Raises exceptions if loading fails - app should not start with missing models.
    """
    global _model, _scaler
    
    try:
        # Load the trained ML model
        model_path = settings.model_path
        if not model_path.exists():
            raise FileNotFoundError(
                f"Model file not found at: {model_path}\n"
                f"Please place 'heart_model.pkl' in the artifacts/ directory"
            )
        
        _model = joblib.load(model_path)
        print(f"✓ Model loaded successfully from {model_path}")
        
    except Exception as e:
        print(f"✗ ERROR loading model: {e}")
        raise
    
    try:
        # Load the scaler
        scaler_path = settings.scaler_path
        if not scaler_path.exists():
            raise FileNotFoundError(
                f"Scaler file not found at: {scaler_path}\n"
                f"Please place 'scaler.pkl' in the artifacts/ directory"
            )
        
        _scaler = joblib.load(scaler_path)
        print(f"✓ Scaler loaded successfully from {scaler_path}")
        
    except Exception as e:
        print(f"✗ ERROR loading scaler: {e}")
        raise


# Load artifacts when module is imported
_load_artifacts()


def get_model():
    """Get the loaded ML model.
    
    Returns:
        The trained scikit-learn model
        
    Raises:
        RuntimeError: If model is not loaded
    """
    if _model is None:
        raise RuntimeError("Model not loaded. Check startup logs.")
    return _model


def get_scaler():
    """Get the loaded scaler.
    
    Returns:
        The trained StandardScaler or MinMaxScaler
        
    Raises:
        RuntimeError: If scaler is not loaded
    """
    if _scaler is None:
        raise RuntimeError("Scaler not loaded. Check startup logs.")
    return _scaler
