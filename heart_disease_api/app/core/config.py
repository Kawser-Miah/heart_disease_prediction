"""Application configuration settings.

Manages paths, constants, and environment variables.
"""

from pydantic_settings import BaseSettings
from pathlib import Path


class Settings(BaseSettings):
    """Application settings and configuration.
    
    Can be overridden by environment variables.
    """
    
    # API Metadata
    app_name: str = "Heart Disease Prediction API"
    version: str = "1.0.0"
    description: str = "Machine learning API for predicting heart disease"
    
    # Path Configuration
    base_dir: Path = Path(__file__).parent.parent.parent
    model_path: Path = base_dir / "artifacts" / "heart-disease-prediction-knn-model.pkl"
    scaler_path: Path = base_dir / "artifacts" / "scaler.pkl"
    
    # Model Configuration
    prediction_threshold: float = 0.5  # Not currently used, but available
    
    # API Configuration
    api_prefix: str = "/api"  # Changed from "/api" - now endpoint is just /predict
    host: str = "0.0.0.0"
    port: int = 8000
    cors_origins: list = ["*"]  # Change in production
    
    class Config:
        env_file = ".env"
        case_sensitive = False


# Singleton instance
settings = Settings()
