"""FastAPI application entry point.

Heart Disease Prediction API
Provides ML-based predictions for heart disease risk assessment.
"""

from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api import predict, test

# Initialize FastAPI application
app = FastAPI(
    title=settings.app_name,
    description=settings.description,
    version=settings.version,
    docs_url="/docs",
    redoc_url="/redoc"
)

# Configure CORS (Cross-Origin Resource Sharing)
# Allows Flutter app to make requests to this API
app.add_middleware(
    CORSMiddleware,
    allow_origins=settings.cors_origins,  # Change to specific origins in production
    allow_credentials=True,
    allow_methods=["*"],  # Allows all HTTP methods
    allow_headers=["*"],  # Allows all headers
)

# Include API routers
app.include_router(
    predict.router,
    prefix=settings.api_prefix,
    tags=["Prediction"]
)

app.include_router(
    test.router,
    prefix=settings.api_prefix,
    tags=["Health"]
)


@app.get(
    "/",
    tags=["Root"],
    summary="API information",
    description="Get API metadata and available endpoints"
)
async def root():
    """Root endpoint - returns API information."""
    return {
        "name": settings.app_name,
        "version": settings.version,
        "description": settings.description,
        "endpoints": {
            "predict": f"{settings.api_prefix}/predict",
            "docs": "/docs",
            "redoc": "/redoc"
        },
        "status": "running"
    }


@app.get(
    "/health",
    tags=["Health"],
    summary="Health check",
    description="Check if the API is running and healthy"
)
async def health_check():
    """Health check endpoint - verifies API is operational."""
    return {
        "status": "healthy",
        "service": settings.app_name,
        "version": settings.version
    }


# Startup event
@app.on_event("startup")
async def startup_event():
    """Actions to perform on application startup."""
    print("=" * 60)
    print(f"🚀 {settings.app_name} v{settings.version}")
    print("=" * 60)
    print(f"📊 Model loaded from: {settings.model_path}")
    print(f"📐 Scaler loaded from: {settings.scaler_path}")
    print(f"📝 Documentation: http://localhost:8000/docs")
    print("=" * 60)


# Shutdown event
@app.on_event("shutdown")
async def shutdown_event():
    """Actions to perform on application shutdown."""
    print("\n👋 Shutting down API...")
