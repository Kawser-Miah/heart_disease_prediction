"""Test script for Heart Disease Prediction API.

Run this after starting the API server to verify everything works.
"""

import requests
import json

# API base URL
BASE_URL = "http://localhost:8000"

# Test data
test_patient = {
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


def test_root():
    """Test root endpoint."""
    print("\n" + "="*60)
    print("Testing Root Endpoint: GET /")
    print("="*60)
    
    response = requests.get(f"{BASE_URL}/")
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    assert response.status_code == 200
    print("✅ Root endpoint working!")


def test_health():
    """Test health check endpoint."""
    print("\n" + "="*60)
    print("Testing Health Check: GET /health")
    print("="*60)
    
    response = requests.get(f"{BASE_URL}/health")
    print(f"Status Code: {response.status_code}")
    print(f"Response: {json.dumps(response.json(), indent=2)}")
    assert response.status_code == 200
    print("✅ Health check working!")


def test_predict():
    """Test prediction endpoint."""
    print("\n" + "="*60)
    print("Testing Prediction: POST /api/predict")
    print("="*60)
    
    print(f"\nRequest Data:")
    print(json.dumps(test_patient, indent=2))
    
    response = requests.post(f"{BASE_URL}/api/predict", json=test_patient)
    print(f"\nStatus Code: {response.status_code}")
    
    if response.status_code == 200:
        result = response.json()
        print(f"\nPrediction Result:")
        print(json.dumps(result, indent=2))
        
        # Validate response structure
        assert "prediction" in result
        assert "probability" in result
        assert "risk_level" in result
        assert isinstance(result["prediction"], bool)
        assert 0 <= result["probability"] <= 1
        assert result["risk_level"] in ["Low", "Medium", "High"]
        
        print("\n✅ Prediction endpoint working correctly!")
        print(f"\n📊 Result Summary:")
        print(f"   - Has Heart Disease: {result['prediction']}")
        print(f"   - Probability: {result['probability']:.2%}")
        print(f"   - Risk Level: {result['risk_level']}")
    else:
        print(f"\n❌ Prediction failed!")
        print(f"Error: {response.text}")


def main():
    """Run all tests."""
    print("\n" + "🧪 " + "="*56 + " 🧪")
    print("   Heart Disease API - Test Suite")
    print("🧪 " + "="*56 + " 🧪")
    
    try:
        test_root()
        test_health()
        test_predict()
        
        print("\n" + "="*60)
        print("✅ ALL TESTS PASSED!")
        print("="*60 + "\n")
        
    except requests.exceptions.ConnectionError:
        print("\n" + "="*60)
        print("❌ ERROR: Cannot connect to API")
        print("="*60)
        print("\nMake sure the API is running:")
        print("   uvicorn app.main:app --reload")
        print()
        
    except AssertionError as e:
        print(f"\n❌ TEST FAILED: {e}\n")
        
    except Exception as e:
        print(f"\n❌ UNEXPECTED ERROR: {e}\n")


if __name__ == "__main__":
    main()
