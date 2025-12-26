# Heart Disease Prediction API 🫀

A production-ready **FastAPI** backend for predicting heart disease using pre-trained machine learning models. Designed for integration with Flutter mobile applications.

---

## 📋 Overview

This API accepts patient health metrics and returns:
- ✅ **Prediction**: Boolean (true/false) indicating presence of heart disease
- 📊 **Probability**: Float value (0.0 to 1.0) representing confidence
- 🎯 **Risk Level**: Categorical assessment (Low, Medium, High)

---

## 🏗️ Project Structure

```
heart_disease_api/
│
├── app/
│   ├── main.py                # FastAPI application entry point
│   │
│   ├── api/
│   │   ├── __init__.py
│   │   └── predict.py         # POST /predict endpoint
│   │
│   ├── core/
│   │   ├── __init__.py
│   │   └── config.py          # Configuration and settings
│   │
│   ├── models/
│   │   ├── __init__.py
│   │   ├── ml_model.py        # Model and scaler loading
│   │   └── predictor.py       # Prediction logic
│   │
│   ├── schemas/
│   │   ├── __init__.py
│   │   └── heart.py           # Pydantic request/response schemas
│   │
│   └── utils/
│       ├── __init__.py
│       └── preprocessing.py   # Feature preprocessing
│
├── artifacts/
│   ├── heart_model.pkl        # Trained ML model (YOU MUST ADD)
│   └── scaler.pkl             # Feature scaler (YOU MUST ADD)
│
├── requirements.txt           # Python dependencies
├── pyproject.toml            # UV project configuration
├── .gitignore
└── README.md
```

---

## 🚀 Prerequisites

- **Python 3.10+**
- **pip** or **uv** package manager
- **Trained model files**:
  - `heart_model.pkl` (your trained scikit-learn model)
  - `scaler.pkl` (StandardScaler or MinMaxScaler)

---

## 📦 Installation

### Step 1: Navigate to project directory
```bash
cd heart_disease_api
```

### Step 2: Create virtual environment (recommended)
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
```

### Step 3: Install dependencies

**Using pip:**
```bash
pip install -r requirements.txt
```

**Using uv (faster):**
```bash
uv pip install -r requirements.txt
```

### Step 4: Add your trained model files
Place your trained model files in the `artifacts/` directory:
```bash
artifacts/
├── heart_model.pkl
└── scaler.pkl
```

> ⚠️ **Important**: The API will not start without these files!

---

## 🏃 Running the API

Start the development server:

```bash
uvicorn app.main:app --reload
```

For production with auto-reload disabled:
```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

The API will be available at:
- **API Base**: http://localhost:8000
- **Interactive Docs (Swagger)**: http://localhost:8000/docs
- **Alternative Docs (ReDoc)**: http://localhost:8000/redoc

---

## 📡 API Endpoints

### 1. Root Endpoint
```http
GET /
```

**Response:**
```json
{
  "name": "Heart Disease Prediction API",
  "version": "1.0.0",
  "description": "Machine learning API for predicting heart disease",
  "endpoints": {
    "predict": "/api/predict",
    "docs": "/docs",
    "redoc": "/redoc"
  },
  "status": "running"
}
```

---

### 2. Health Check
```http
GET /health
```

**Response:**
```json
{
  "status": "healthy",
  "service": "Heart Disease Prediction API",
  "version": "1.0.0"
}
```

---

### 3. Predict Heart Disease ⭐
```http
POST /api/predict
```

**Request Headers:**
```
Content-Type: application/json
```

**Request Body:**
```json
{
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
```

**Response (200 OK):**
```json
{
  "prediction": true,
  "probability": 0.8523,
  "risk_level": "High"
}
```

**Response (422 Validation Error):**
```json
{
  "detail": [
    {
      "loc": ["body", "age"],
      "msg": "ensure this value is greater than or equal to 1",
      "type": "value_error.number.not_ge"
    }
  ]
}
```

**Response (500 Server Error):**
```json
{
  "detail": "Prediction error: Model file not found"
}
```

---

## 📊 Feature Descriptions

| Feature | Description | Type | Range | Example |
|---------|-------------|------|-------|---------|
| `age` | Age in years | int | 1-120 | 63 |
| `sex` | Biological sex | int | 0-1 | 1 (male) |
| `cp` | Chest pain type | int | 0-3 | 3 |
| `trestbps` | Resting blood pressure (mm Hg) | int | 50-250 | 145 |
| `chol` | Serum cholesterol (mg/dl) | int | 100-600 | 233 |
| `fbs` | Fasting blood sugar > 120 mg/dl | int | 0-1 | 1 (true) |
| `restecg` | Resting ECG results | int | 0-2 | 0 |
| `thalach` | Maximum heart rate achieved | int | 50-250 | 150 |
| `exang` | Exercise induced angina | int | 0-1 | 0 (no) |
| `oldpeak` | ST depression induced by exercise | float | 0-10 | 2.3 |
| `slope` | Slope of peak exercise ST segment | int | 0-2 | 0 |
| `ca` | Number of major vessels (fluoroscopy) | int | 0-4 | 0 |
| `thal` | Thalassemia | int | 0-3 | 1 |

---

## 🎯 Risk Level Thresholds

| Probability | Risk Level |
|-------------|-----------|
| ≥ 0.7 | **High** |
| 0.4 - 0.69 | **Medium** |
| < 0.4 | **Low** |

---

## 🧪 Testing the API

### Using cURL:
```bash
curl -X POST "http://localhost:8000/api/predict" \
  -H "Content-Type: application/json" \
  -d '{
    "age": 63, "sex": 1, "cp": 3, "trestbps": 145,
    "chol": 233, "fbs": 1, "restecg": 0, "thalach": 150,
    "exang": 0, "oldpeak": 2.3, "slope": 0, "ca": 0, "thal": 1
  }'
```

### Using Python `requests`:
```python
import requests

url = "http://localhost:8000/api/predict"

data = {
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

response = requests.post(url, json=data)
print(response.json())
```

### Using HTTPie:
```bash
http POST localhost:8000/api/predict \
  age:=63 sex:=1 cp:=3 trestbps:=145 chol:=233 fbs:=1 \
  restecg:=0 thalach:=150 exang:=0 oldpeak:=2.3 \
  slope:=0 ca:=0 thal:=1
```

---

## 🔧 Configuration

Edit [app/core/config.py](app/core/config.py) to customize:

```python
class Settings(BaseSettings):
    app_name: str = "Heart Disease Prediction API"
    version: str = "1.0.0"
    
    # Model paths
    model_path: Path = base_dir / "artifacts" / "heart_model.pkl"
    scaler_path: Path = base_dir / "artifacts" / "scaler.pkl"
    
    # CORS origins (change for production)
    cors_origins: list = ["*"]
```

For production, create a `.env` file:
```env
CORS_ORIGINS=["https://your-flutter-app.com"]
```

---

## 🚢 Deployment

### Using Docker (Recommended)

Create `Dockerfile`:
```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

Build and run:
```bash
docker build -t heart-disease-api .
docker run -p 8000:8000 heart-disease-api
```

### Using systemd

Create `/etc/systemd/system/heart-api.service`:
```ini
[Unit]
Description=Heart Disease API
After=network.target

[Service]
User=www-data
WorkingDirectory=/path/to/heart_disease_api
ExecStart=/path/to/venv/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000
Restart=always

[Install]
WantedBy=multi-user.target
```

---

## 🔒 Security Best Practices

- [ ] Change CORS origins from `["*"]` to specific domains
- [ ] Add authentication (API keys, OAuth2, JWT)
- [ ] Use HTTPS in production (reverse proxy with nginx/traefik)
- [ ] Implement rate limiting
- [ ] Validate and sanitize all inputs
- [ ] Keep dependencies updated
- [ ] Use environment variables for secrets

---

## 📝 Dependencies

- **FastAPI** - Modern web framework
- **Uvicorn** - ASGI server
- **Pydantic** - Data validation
- **NumPy** - Numerical computations
- **Scikit-learn** - ML model support
- **Joblib** - Model serialization

---

## 🐛 Troubleshooting

### Model file not found
```
✗ ERROR loading model: Model file not found at: /path/to/artifacts/heart_model.pkl
```
**Solution**: Ensure `heart_model.pkl` and `scaler.pkl` are in the `artifacts/` directory.

### Import errors
```
ModuleNotFoundError: No module named 'fastapi'
```
**Solution**: Install dependencies: `pip install -r requirements.txt`

### Port already in use
```
ERROR: [Errno 48] Address already in use
```
**Solution**: Change port: `uvicorn app.main:app --port 8001`

---

## 📄 License

This project is for educational purposes.

---

## 👨‍💻 Author

**AI Lab Project - CSE316**

---

## 📞 Support

For issues or questions, please open an issue in the repository.

---

**Made with ❤️ using FastAPI**
