from fastapi import APIRouter, HTTPException, status

router = APIRouter()

@router.get(
    "/health",
    tags=["Health"],
    summary="Health check",
    description="Check if the API is running and healthy",
    status_code=status.HTTP_200_OK
)
async def health_check():
    """Health check endpoint - verifies API is operational."""
    return {
        "status": "healthy",
        "service": "Heart Disease Prediction API",
        "version": "1.0.0"
    }