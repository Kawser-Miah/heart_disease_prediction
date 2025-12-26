"""
QUICK START GUIDE
Heart Disease Prediction API
==========================================

Follow these steps to get the API running:
"""

# ==========================================
# STEP 1: Install Dependencies
# ==========================================
print("""
STEP 1: Install Dependencies
-----------------------------
Run one of these commands:

Option A (using pip):
    pip install -r requirements.txt

Option B (using uv - faster):
    uv pip install -r requirements.txt
""")

# ==========================================
# STEP 2: Add Model Files
# ==========================================
print("""
STEP 2: Add Your Trained Model Files
-------------------------------------
Place these files in the artifacts/ directory:

    artifacts/
    ├── heart_model.pkl    <- Your trained scikit-learn model
    └── scaler.pkl         <- Your StandardScaler/MinMaxScaler

⚠️  IMPORTANT: The API will NOT start without these files!
""")

# ==========================================
# STEP 3: Start the API
# ==========================================
print("""
STEP 3: Start the API Server
-----------------------------
Run this command:

    uvicorn app.main:app --reload

You should see:
    ✓ Model loaded successfully
    ✓ Scaler loaded successfully
    🚀 Application startup complete
    
Access the API at:
    - API: http://localhost:8000
    - Docs: http://localhost:8000/docs
""")

# ==========================================
# STEP 4: Test the API
# ==========================================
print("""
STEP 4: Test the API
--------------------
Open another terminal and run:

    python test_api.py

Or visit the interactive docs:
    http://localhost:8000/docs

Or use curl:
    curl -X POST "http://localhost:8000/api/predict" \\
      -H "Content-Type: application/json" \\
      -d '{
        "age": 63, "sex": 1, "cp": 3, "trestbps": 145,
        "chol": 233, "fbs": 1, "restecg": 0, "thalach": 150,
        "exang": 0, "oldpeak": 2.3, "slope": 0, "ca": 0, "thal": 1
      }'
""")

# ==========================================
# TROUBLESHOOTING
# ==========================================
print("""
==========================================
TROUBLESHOOTING
==========================================

Problem: Model file not found
Solution: Ensure heart_model.pkl and scaler.pkl are in artifacts/

Problem: Port already in use
Solution: uvicorn app.main:app --port 8001

Problem: Import errors
Solution: Activate virtual environment and reinstall dependencies

Problem: Module not found
Solution: Run from project root directory

==========================================
For more help, see README.md
==========================================
""")
