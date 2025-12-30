# 🫀 CardioCare AI - Complete Project Documentation

**Full-Stack Heart Disease Prediction Application**  
*Flutter Mobile App + FastAPI Backend + Machine Learning*

**Version:** 1.0.0  
**Last Updated:** December 30, 2025  
**Project Location:** `https://github.com/Kawser-Miah/heart_disease_prediction`

---

## 📑 Table of Contents

1. [Project Overview](#project-overview)
2. [System Architecture](#system-architecture)
3. [Technology Stack](#technology-stack)
4. [Backend API (FastAPI)](#backend-api-fastapi)
5. [Flutter Mobile Application](#flutter-mobile-application)
6. [Data Models & Business Logic](#data-models--business-logic)
7. [Database Architecture](#database-architecture)
8. [Firebase Integration](#firebase-integration)
9. [API Integration](#api-integration)
10. [Installation & Setup](#installation--setup)
11. [Running the Application](#running-the-application)
12. [Project Structure](#project-structure)
13. [Features Breakdown](#features-breakdown)
14. [Security & Best Practices](#security--best-practices)
15. [Testing](#testing)
16. [Deployment Guide](#deployment-guide)
17. [Troubleshooting](#troubleshooting)

---

## 🎯 Project Overview

### What is CardioCare AI?

CardioCare AI is a comprehensive mobile health application that leverages machine learning to predict heart disease risk. It consists of two main components:

1. **Flutter Mobile App**: Cross-platform mobile application (Android/iOS)
2. **FastAPI Backend**: RESTful API with ML model serving

### Key Objectives

- ✅ Early detection of cardiovascular disease risk
- ✅ AI-powered risk assessment using 13 medical parameters
- ✅ Personalized health recommendations
- ✅ Historical assessment tracking
- ✅ User authentication and profile management
- ✅ Real-time predictions with probability scoring

### Target Users

- 👥 Individual health-conscious users
- 🏥 Healthcare professionals for preliminary screening
- 📊 Medical research institutions

---

## 🏗️ System Architecture

### High-Level Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│                    FLUTTER MOBILE APP                       │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Presentation Layer (Screens & Widgets)               │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Business Logic Layer (BLoC State Management)         │  │
│  │  • AssessmentBloc  • ProfileBloc                      │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Data Layer (Repositories & Data Sources)             │  │
│  │  • Local DB (Floor/SQLite)  • Remote API (Dio)       │  │
│  │  • SharedPreferences        • Firebase                │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ HTTP/HTTPS REST API
                            ▼
┌─────────────────────────────────────────────────────────────┐
│                  FASTAPI BACKEND SERVER                     │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  API Layer (REST Endpoints)                           │  │
│  │  • POST /api/predict  • GET /health                   │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  Business Logic Layer (Prediction Logic)              │  │
│  │  • HeartDiseasePredictor                              │  │
│  └───────────────────────────────────────────────────────┘  │
│  ┌───────────────────────────────────────────────────────┐  │
│  │  ML Model Layer                                       │  │
│  │  • RF(Random Forest) (scikit-learn)                      │  │
│  │  • StandardScaler                                     │  │
│  └───────────────────────────────────────────────────────┘  │
└─────────────────────────────────────────────────────────────┘
                            │
                            │ Model Files (.pkl)
                            ▼
┌─────────────────────────────────────────────────────────────┐
│              MACHINE LEARNING ARTIFACTS                     │
│  • heart-disease-prediction-model.pkl                   │
│  • scaler.pkl                                               │
└─────────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────────┐
│                    FIREBASE SERVICES                        │
│  • Firebase Authentication (User Management)                │
│  • Cloud Firestore (User Data Sync)                        │
└─────────────────────────────────────────────────────────────┘
```

### Architecture Pattern

**Flutter App:** Clean Architecture + BLoC Pattern
- **Presentation Layer**: UI components (screens, widgets)
- **Business Logic Layer**: BLoC for state management
- **Data Layer**: Repositories, data sources (local & remote)

**Backend API:** Layered Architecture
- **API Layer**: FastAPI routers and endpoints
- **Service Layer**: Business logic and validation
- **Data Layer**: ML model loading and preprocessing

---

## 💻 Technology Stack

### Frontend (Flutter)

| Category | Technology | Version | Purpose |
|----------|-----------|---------|---------|
| **Framework** | Flutter | 3.10.1+ | Cross-platform mobile development |
| **Language** | Dart | 3.10.1+ | Programming language |
| **State Management** | flutter_bloc | 9.1.1 | Business logic component pattern |
| **HTTP Client** | dio | 5.9.0 | REST API communication |
| **Local Database** | floor | 1.5.0 | SQLite ORM for Dart |
| **Local Storage** | shared_preferences | 2.5.4 | Key-value storage |
| **Authentication** | firebase_auth | 6.1.3 | User authentication |
| **Cloud Database** | cloud_firestore | 6.1.1 | Real-time database |
| **UI/Fonts** | google_fonts | 6.3.3 | Custom typography |
| **Animations** | animate_do | 4.2.0 | Pre-built animations |
| **Charts** | percent_indicator | 4.2.5 | Progress indicators |
| **HTML Rendering** | flutter_html | 3.0.0 | Rich text display |
| **Utilities** | uuid | 4.5.2 | Unique ID generation |
| **Internationalization** | intl | 0.19.0 | Date/number formatting |

### Backend (Python)

| Category | Technology | Version | Purpose |
|----------|-----------|---------|---------|
| **Framework** | FastAPI | 0.109.0+ | REST API framework |
| **ASGI Server** | uvicorn | 0.27.0+ | Production server |
| **Validation** | pydantic | 2.5.3+ | Data validation |
| **ML Framework** | scikit-learn | 1.6.1+ | Machine learning |
| **Numerical Computing** | numpy | 1.24.3+ | Array operations |
| **Model Serialization** | joblib | 1.3.2+ | Model loading |
| **File Upload** | python-multipart | 0.0.6+ | Multipart form data |

### Machine Learning

- **Algorithm**: Random Forest (RF) Classifier
- **Preprocessing**: StandardScaler for feature normalization
- **Framework**: scikit-learn
- **Model Format**: Pickle (.pkl)

### Development Tools

- **Version Control**: Git
- **Package Management**: 
  - Flutter: pub
  - Python: pip/uv
- **Build System**: 
  - Flutter: flutter build
  - Android: Gradle (Kotlin DSL)
- **Database**: SQLite (via Floor ORM)

---

## 🔧 Backend API (FastAPI)

### API Directory Structure

```
heart_disease_api/
├── app/
│   ├── main.py                    # FastAPI application entry point
│   ├── api/
│   │   ├── predict.py            # POST /api/predict endpoint
│   │   └── test.py               # Health check endpoints
│   ├── core/
│   │   └── config.py             # Configuration settings
│   ├── models/
│   │   ├── ml_model.py           # Model loader
│   │   └── predictor.py          # Prediction logic
│   ├── schemas/
│   │   └── heart.py              # Pydantic schemas
│   └── utils/
│       └── preprocessing.py      # Feature preprocessing
├── artifacts/
│   ├── heart-disease-prediction-model.pkl
│   └── scaler.pkl
├── requirements.txt
├── run.py                         # Application runner
└── test_api.py                    # API test suite
```

### API Endpoints

#### 1. Root Endpoint
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

#### 2. Health Check
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

#### 3. Prediction Endpoint
```http
POST /api/predict
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

**Response:**
```json
{
  "prediction": true,
  "probability": 0.8523,
  "risk_level": "High"
}
```

### Input Parameters

| Parameter | Type | Range | Description |
|-----------|------|-------|-------------|
| `age` | int | 1-120 | Age in years |
| `sex` | int | 0-1 | 0 = female, 1 = male |
| `cp` | int | 0-3 | Chest pain type |
| `trestbps` | int | 50-250 | Resting blood pressure (mm Hg) |
| `chol` | int | 100-600 | Serum cholesterol (mg/dl) |
| `fbs` | int | 0-1 | Fasting blood sugar > 120 mg/dl |
| `restecg` | int | 0-2 | Resting ECG results |
| `thalach` | int | 50-250 | Maximum heart rate achieved |
| `exang` | int | 0-1 | Exercise induced angina |
| `oldpeak` | float | 0-10 | ST depression |
| `slope` | int | 0-2 | Slope of peak exercise ST segment |
| `ca` | int | 0-4 | Number of major vessels |
| `thal` | int | 0-3 | Thalassemia type |

### Risk Level Thresholds

| Probability | Risk Level | Description |
|------------|------------|-------------|
| ≥ 0.7 | High | Significant cardiovascular risk |
| 0.4 - 0.69 | Medium | Moderate risk, monitoring recommended |
| < 0.4 | Low | Low risk, maintain healthy lifestyle |

### Core Backend Components

#### 1. Configuration (config.py)
```python
class Settings(BaseSettings):
    app_name: str = "Heart Disease Prediction API"
    version: str = "1.0.0"
    model_path: Path = "artifacts/heart-disease-prediction-model.pkl"
    scaler_path: Path = "artifacts/scaler.pkl"
    prediction_threshold: float = 0.5
    api_prefix: str = "/api"
    host: str = "0.0.0.0"
    port: int = 8000
    cors_origins: list = ["*"]
```

#### 2. Model Loader (ml_model.py)
- Loads pre-trained RF model at startup
- Loads StandardScaler for feature normalization
- Module-level caching for performance
- Automatic validation of artifact files

#### 3. Predictor (predictor.py)
**Prediction Workflow:**
1. Preprocess input data (feature ordering + scaling)
2. Apply ML model (RF classifier)
3. Calculate probability (predict_proba)
4. Determine binary prediction
5. Assign risk level based on thresholds
6. Return structured response

#### 4. Preprocessing (preprocessing.py)
**Critical Feature Order:**
```python
FEATURE_ORDER = [
    'age', 'sex', 'cp', 'trestbps', 'chol', 'fbs', 'restecg',
    'thalach', 'exang', 'oldpeak', 'slope', 'ca', 'thal'
]
```
⚠️ **Warning**: This order MUST match the training data order!

### CORS Configuration

```python
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Change to specific origins in production
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
```

### Error Handling

- **422**: Validation error (invalid input data)
- **500**: Server error (prediction failed)
- **404**: Endpoint not found

---

## 📱 Flutter Mobile Application

### Application Architecture

```
lib/
├── main.dart                      # App entry point
├── firebase_options.dart          # Firebase configuration
├── blocs/                         # State management
│   ├── assessment_bloc.dart       # Assessment business logic
│   ├── assessment_event.dart      # Assessment events
│   ├── assessment_state.dart      # Assessment states
│   ├── profile_bloc.dart          # Profile business logic
│   ├── profile_event.dart         # Profile events
│   └── profile_state.dart         # Profile states
├── config/                        # Configuration
│   ├── app_colors.dart           # Color palette
│   └── app_constants.dart        # App-wide constants
├── data/                          # Data layer
│   ├── repository/               # Abstract repository interfaces
│   └── repository_iml/           # Repository implementations
│       ├── authentication_repository_iml.dart
│       ├── factor_contribution_repo_iml.dart
│       ├── health_assessment_repo_iml.dart
│       └── heart_disease_repository_iml.dart
├── datasource/                    # Data sources
│   ├── datafrom_remote_source.dart  # API client
│   └── db/                       # Local database
│       ├── heart_disease_db.dart # Floor database
│       ├── heart_disease_db.g.dart
│       └── dao/                  # Data access objects
├── models/                        # Data models
│   ├── health_assessment.dart    # Assessment model
│   ├── prediction_response.dart  # API response model
│   └── user_profile.dart         # User profile model
├── screens/                       # UI screens
│   ├── splash_screen.dart        # App launch screen
│   ├── auth_gate.dart            # Authentication gate
│   ├── log_in_screen.dart        # Login screen
│   ├── home_screen.dart          # Main dashboard
│   ├── check_screen.dart         # Assessment form
│   ├── analyzing_screen.dart     # Loading animation
│   ├── result_screen.dart        # Results display
│   ├── explain_screen.dart       # AI explanation
│   ├── history_screen.dart       # Assessment history
│   ├── profile_screen.dart       # User profile
│   ├── about_heart_disease_screen.dart
│   └── heart_health_tips_screen.dart
├── utils/                         # Utilities
│   ├── risk_calculator.dart      # Risk calculation logic
│   ├── storage_service.dart      # SharedPreferences wrapper
│   └── helpers.dart              # Helper functions
└── widgets/                       # Reusable widgets
```

### Screen Flow Diagram

```
┌─────────────┐
│ SplashScreen│
└──────┬──────┘
       │
       ▼
┌─────────────┐
│  AuthGate   │
└──────┬──────┘
       │
       ├─── Not Authenticated ──► LoginScreen
       │
       └─── Authenticated ──────► HomeScreen
                                      │
                      ┌───────────────┼───────────────┐
                      │               │               │
                      ▼               ▼               ▼
                CheckScreen    HistoryScreen    ProfileScreen
                      │
                      ▼
              AnalyzingScreen
                      │
                      ▼
              ResultScreen
                      │
                      ▼
              ExplainScreen
```

### BLoC State Management

#### AssessmentBloc

**Events:**
- `UpdateFormField`: Updates form data
- `SubmitAssessment`: Submits form for prediction
- `LoadAssessmentHistory`: Loads past assessments
- `ClearCurrentAssessment`: Resets current assessment
- `DeleteAssessment`: Removes an assessment
- `LoginEvent`: Handles user login
- `LogoutEvent`: Handles user logout

**States:**
- `AssessmentInitial`: Initial state
- `AssessmentFormInProgress`: Form being filled
- `AssessmentAnalyzing`: Prediction in progress
- `AssessmentCompleted`: Prediction completed
- `AssessmentHistoryLoaded`: History retrieved
- `AssessmentError`: Error occurred

**Workflow:**
```dart
UpdateFormField → AssessmentFormInProgress
SubmitAssessment → AssessmentAnalyzing → AssessmentCompleted
LoadAssessmentHistory → AssessmentHistoryLoaded
```

#### ProfileBloc

**Events:**
- `LoadProfile`: Loads user profile
- `UpdateProfile`: Updates user profile

**States:**
- `ProfileInitial`: Initial state
- `ProfileLoading`: Loading profile
- `ProfileLoaded`: Profile retrieved
- `ProfileError`: Error occurred

---

## 📊 Data Models & Business Logic

### 1. HealthAssessment Model

```dart
class HealthAssessment {
  final String id;                    // Unique identifier (UUID)
  final DateTime date;                // Assessment timestamp
  final bool prediction;              // Has heart disease (true/false)
  final String riskLevel;             // "Low" | "Medium" | "High"
  final double riskPercentage;        // 0.0 to 1.0
  final List<String> recommendations; // Health recommendations
  final List<FactorContribution> contributingFactors;
}
```

### 2. FormData Model

```dart
class FormData {
  final String age;
  final String sex;
  final String chestPainType;
  final bool exerciseInducedAngina;
  final String stDepression;
  final String restingBP;
  final String cholesterol;
  final String maxHeartRate;
  final bool fastingBloodSugar;
  final String restingECG;
  final String stSlope;
  final String numVessels;
  final String thalassemia;
}
```

### 3. FactorContribution Model

```dart
class FactorContribution {
  final String foreignKey;      // Links to HealthAssessment
  final String type;             // Factor category
  final String factorName;       // Display name
  final String impact;           // "low" | "medium" | "high"
  final double contribution;     // 0.0 to 1.0
  final String explanation;      // Detailed explanation
}
```

### 4. UserProfile Model

```dart
class UserProfile {
  final String name;
  final String email;
  final String? phone;
  final String? emergencyContact;
  final String? bloodType;
  final DateTime dateOfBirth;
  final String? avatarUrl;
}
```

### 5. PredictionResponse Model (API Response)

```dart
class PredictionResponse {
  final bool prediction;
  final double probability;
  final String riskLevel;
}
```

### Risk Calculator Logic

**Purpose**: Analyzes form data to identify contributing risk factors

**Key Methods:**
```dart
RiskResult calculateRisk(FormData data, String riskLevel, String foreignKey)
```

**Factor Categories:**
1. **Age Factors**
   - Age > 60: High impact (0.25)
   - Age 50-60: Medium impact (0.15)
   - Age 40-50: Low impact (0.10)

2. **Chest Pain Type**
   - Typical Angina: High impact (0.30)
   - Atypical Angina: Medium impact (0.20)
   - Non-Anginal: Low impact (0.10)

3. **Blood Pressure**
   - Hypertension Stage 2 (>160): High impact (0.20)
   - Hypertension Stage 1 (140-159): Medium impact (0.15)
   - Elevated (120-139): Low impact (0.10)

4. **Cholesterol Levels**
   - Very High (>280): High impact (0.20)
   - High (240-280): Medium impact (0.15)
   - Borderline (200-239): Low impact (0.10)

5. **Heart Rate**
   - Abnormal rates trigger warnings

6. **ECG Results**
   - Abnormalities flagged

7. **Exercise-Induced Angina**
   - Present: High impact (0.25)

8. **ST Depression**
   - Significant depression indicates risk

9. **Number of Vessels**
   - More blocked vessels = higher risk

10. **Thalassemia**
    - Certain types increase risk

---

## 🗄️ Database Architecture

### Local Database (Floor/SQLite)

#### Database Setup
```dart
@Database(version: 1, entities: [
  HealthAssessmentEntity,
  FactorContributionEntity
])
abstract class HeartDiseaseDb extends FloorDatabase {
  HealthAssessmentDao get healthAssessmentDao;
  FactorContributionDao get factorContributionDao;
}
```

#### HealthAssessmentEntity

```dart
@Entity(tableName: 'health_assessments')
class HealthAssessmentEntity {
  @PrimaryKey()
  final String id;
  final String date;
  final bool prediction;
  final String riskLevel;
  final double riskPercentage;
}
```

#### FactorContributionEntity

```dart
@Entity(tableName: 'factor_contributions')
class FactorContributionEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String foreignKey;  // References HealthAssessment.id
  final String type;
  final String factorName;
  final String impact;
  final double contribution;
  final String explanation;
}
```

### SharedPreferences Storage

**Stored Data:**
- Assessment history (JSON serialized)
- User profile (JSON serialized)
- Onboarding completion flag

**Keys:**
```dart
static const String keyAssessments = 'assessments';
static const String keyUserProfile = 'user_profile';
static const String keyOnboardingComplete = 'onboarding_complete';
```

---

## 🔥 Firebase Integration

### Firebase Services Used

#### 1. Firebase Authentication
```dart
FirebaseAuth firebaseAuth = FirebaseAuth.instance;
```

**Features:**
- Email/password authentication
- Google Sign-In integration
- User session management
- Password reset functionality

#### 2. Cloud Firestore
```dart
FirebaseFirestore firestore = FirebaseFirestore.instance;
```

**Collections:**
- `users/` - User profile data
- `assessments/` - Synced assessment history

**Use Case:**
- Cloud backup of assessments
- Cross-device synchronization
- User profile storage

### Firebase Configuration

**File:** `firebase_options.dart`
```dart
static const FirebaseOptions currentPlatform = FirebaseOptions(
  apiKey: "...",
  appId: "1:955170453302:android:b82de84666ca4bfb642597",
  projectId: "heart-disease-prediction-59d0b",
  // ... other config
);
```

**Android Configuration:** `android/app/google-services.json`

---

## 🔌 API Integration

### HTTP Client Configuration

**Library:** Dio (v5.9.0)

```dart
class DataFromRemoteSource {
  final Dio _dio;
  
  Future<PredictionResponse> predict({required FormData formData}) async {
    final response = await _dio.post(
      'http://192.168.0.123:8000/api/predict',
      data: formData.toJson(),
      options: Options(headers: {'Content-Type': 'application/json'}),
    );
    return PredictionResponse.fromJson(response.data);
  }
}
```

### API Endpoint Configuration

**Current:** `http://192.168.0.123:8000`

⚠️ **Note**: Update this IP address to match your backend server:
- **Local Development**: Use machine's local IP (e.g., 192.168.x.x)
- **Production**: Use domain name or public IP

**Location to Update:**
```
lib/datasource/datafrom_remote_source.dart
```

### FormData Serialization

```dart
Map<String, dynamic> toJson() {
  return {
    'age': int.parse(age),
    'sex': sex == 'Male' ? 1 : 0,
    'cp': _mapChestPainType(chestPainType),
    'trestbps': int.parse(restingBP),
    'chol': int.parse(cholesterol),
    'fbs': fastingBloodSugar ? 1 : 0,
    'restecg': int.parse(restingECG),
    'thalach': int.parse(maxHeartRate),
    'exang': exerciseInducedAngina ? 1 : 0,
    'oldpeak': double.parse(stDepression),
    'slope': int.parse(stSlope),
    'ca': int.parse(numVessels),
    'thal': int.parse(thalassemia),
  };
}
```

### Error Handling

```dart
try {
  final result = await heartDiseaseRepository.getHeartDiseasePrediction(formData);
} on DioException catch (e) {
  throw Exception(e.response?.data ?? 'Prediction request failed');
} catch (e) {
  throw Exception('Unexpected error: $e');
}
```

---

## 🚀 Installation & Setup

### Prerequisites

#### For Flutter Development:
- Flutter SDK 3.10.1+
- Dart SDK 3.10.1+
- Android Studio / Xcode
- VS Code with Flutter extension (recommended)
- Git

#### For Backend Development:
- Python 3.10+
- pip or uv package manager
- Virtual environment (recommended)

### Step 1: Clone/Navigate to Project

```bash
cd https://github.com/Kawser-Miah/heart_disease_prediction
```

### Step 2: Backend Setup

```bash
# Navigate to backend directory
cd heart_disease_api

# Create virtual environment (optional but recommended)
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Verify model files exist
ls -la artifacts/
# Should show:
# - heart-disease-prediction-model.pkl
# - scaler.pkl
```

### Step 3: Flutter App Setup

```bash
# Navigate to project root
cd https://github.com/Kawser-Miah/heart_disease_prediction

# Get dependencies
flutter pub get

# Generate Floor database code
flutter packages pub run build_runner build

# Verify Firebase configuration
cat lib/firebase_options.dart

# Check Flutter doctor
flutter doctor
```

### Step 4: Configure API Endpoint

1. Find your machine's local IP address:
   ```bash
   # Linux
   hostname -I | awk '{print $1}'
   
   # macOS
   ipconfig getifaddr en0
   
   # Windows
   ipconfig
   ```

2. Update API endpoint in Flutter app:
   ```dart
   // lib/datasource/datafrom_remote_source.dart
   'http://YOUR_LOCAL_IP:8000/api/predict'
   ```

### Step 5: Firebase Setup (Optional)

1. Create Firebase project at console.firebase.google.com
2. Add Android app with package name: `com.example.heart_disease_prediction`
3. Download `google-services.json` to `android/app/`
4. Run Firebase FlutterFire CLI:
   ```bash
   flutterfire configure
   ```

---

## ▶️ Running the Application

### Start Backend Server

**Method 1: Using run.py**
```bash
cd heart_disease_api
python run.py
```

**Method 2: Using uvicorn directly**
```bash
cd heart_disease_api
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

**Expected Output:**
```
============================================================
🚀 Heart Disease Prediction API v1.0.0
============================================================
📊 Model loaded from: artifacts/heart-disease-prediction-model.pkl
📐 Scaler loaded from: artifacts/scaler.pkl
📝 Documentation: http://localhost:8000/docs
============================================================
INFO:     Uvicorn running on http://0.0.0.0:8000
```

### Test Backend API

```bash
cd heart_disease_api
python test_api.py
```

**Or manually test with curl:**
```bash
curl -X POST http://localhost:8000/api/predict \
  -H "Content-Type: application/json" \
  -d '{
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
  }'
```

### Start Flutter App

**Method 1: Command Line**
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run in release mode (optimized)
flutter run --release
```

**Method 2: VS Code**
1. Open project in VS Code
2. Open `lib/main.dart`
3. Press F5 or click "Run" → "Start Debugging"

**Method 3: Android Studio**
1. Open project in Android Studio
2. Select device from dropdown
3. Click Run button (▶️)

### Verify Integration

1. Launch Flutter app
2. Navigate to "Check" screen
3. Fill out health assessment form
4. Submit form
5. Verify backend receives request (check terminal logs)
6. View prediction results

---

## 📁 Project Structure

### Complete File Tree

```
heart_disease_prediction/
│
├── android/                          # Android native code
│   ├── app/
│   │   ├── build.gradle.kts
│   │   ├── google-services.json     # Firebase config
│   │   └── src/
│   ├── build.gradle.kts
│   └── gradle/
│
├── ios/                              # iOS native code
│   ├── Runner/
│   └── Runner.xcworkspace/
│
├── lib/                              # Flutter Dart code
│   ├── main.dart                     # Entry point
│   ├── firebase_options.dart
│   ├── blocs/                        # State management
│   ├── config/                       # Configuration
│   ├── data/                         # Data layer
│   ├── datasource/                   # Data sources
│   ├── models/                       # Data models
│   ├── screens/                      # UI screens
│   ├── utils/                        # Utilities
│   └── widgets/                      # Reusable widgets
│
├── heart_disease_api/                # Backend API
│   ├── app/
│   │   ├── main.py
│   │   ├── api/                      # API endpoints
│   │   ├── core/                     # Configuration
│   │   ├── models/                   # ML models
│   │   ├── schemas/                  # Data schemas
│   │   └── utils/                    # Utilities
│   ├── artifacts/                    # ML model files
│   │   ├── heart-disease-prediction-model.pkl
│   │   └── scaler.pkl
│   ├── requirements.txt
│   ├── run.py
│   └── test_api.py
│
├── test/                             # Flutter tests
│   └── widget_test.dart
│
├── pubspec.yaml                      # Flutter dependencies
├── firebase.json                     # Firebase config
├── analysis_options.yaml             # Linting rules
├── README.md
├── PROJECT_SUMMARY.md
├── SETUP.md
├── GET_STARTED.md
├── CHECKLIST.md
└── COMPREHENSIVE_PROJECT_DOCUMENTATION.md  # This file
```

---

## ✨ Features Breakdown

### 1. Splash Screen
- **Duration**: 3 seconds
- **Animation**: Pulse effect on logo
- **Purpose**: App initialization

### 2. Authentication
- **Firebase Auth**: Email/password + Google Sign-In
- **Auth Gate**: Automatic route protection
- **Features**:
  - User registration
  - Login
  - Password reset
  - Session persistence

### 3. Home Screen
- **Last Assessment Card**: Quick view of most recent result
- **Risk Level Indicator**: Color-coded badge
- **Quick Actions**:
  - New Assessment
  - View History
  - Health Tips
- **Bottom Navigation**: Home, History, Profile

### 4. Health Assessment Form (Check Screen)
- **13 Input Fields**: Age, sex, BP, cholesterol, etc.
- **Input Types**:
  - Text fields (numeric)
  - Dropdowns
  - Switches (boolean)
- **Validation**: Real-time field validation
- **Helper Text**: Explanations for each parameter
- **Progress Tracking**: Form completion percentage

### 5. Analyzing Screen
- **Duration**: 3 seconds
- **Animations**:
  - Rotating heart icon
  - Progress indicator
  - Heartbeat wave
- **Purpose**: Backend API call + loading UX

### 6. Result Screen
- **Risk Percentage**: Circular progress indicator
- **Risk Badge**: Color-coded (Low/Medium/High)
- **Recommendations**: Personalized list
- **Actions**:
  - View AI Explanation
  - Download Report (future)
  - Share with Doctor (future)
- **Disclaimer**: Medical advice disclaimer

### 7. AI Explanation Screen
- **Contributing Factors**: Detailed breakdown
- **Impact Levels**: High, Medium, Low
- **Factor Details**:
  - Factor name
  - Impact score
  - Medical explanation
- **Visualization**: Impact bars

### 8. Assessment History
- **List View**: All past assessments
- **Sorting**: Newest first
- **Details**: Date, risk level, percentage
- **Actions**:
  - View details
  - Delete assessment
  - Swipe to delete
- **Empty State**: Encouragement to take first assessment

### 9. User Profile
- **Editable Fields**:
  - Name
  - Email
  - Phone
  - Emergency contact
  - Blood type
  - Date of birth
- **Actions**:
  - Edit profile
  - Logout
  - Delete account (future)

### 10. Additional Screens
- **About Heart Disease**: Educational content
- **Heart Health Tips**: Lifestyle recommendations

---

## 🔐 Security & Best Practices

### Backend Security

1. **CORS Configuration**
   ```python
   # Production: Restrict to specific origins
   allow_origins=["https://yourdomain.com"]
   ```

2. **Input Validation**
   - Pydantic schemas enforce type checking
   - Range validation on all numeric inputs
   - Prevents SQL injection (no SQL used)

3. **Error Messages**
   - Generic error messages to prevent information leakage
   - Detailed logging for debugging

4. **HTTPS**
   - Use HTTPS in production
   - Configure SSL certificates

### Flutter Security

1. **API Keys**
   - Store in environment variables
   - Never commit to version control
   - Use Flutter dotenv package

2. **Authentication**
   - Firebase secure token handling
   - Automatic session timeout
   - Secure storage of tokens

3. **Data Encryption**
   - SharedPreferences data is unencrypted
   - Consider flutter_secure_storage for sensitive data

4. **Network Security**
   - Use HTTPS for API calls
   - Certificate pinning (future enhancement)

### Best Practices

1. **Code Quality**
   - Follow Flutter style guide
   - Use linter (analysis_options.yaml)
   - Regular code reviews

2. **State Management**
   - BLoC pattern for separation of concerns
   - Immutable state objects
   - Proper error handling

3. **Testing**
   - Unit tests for business logic
   - Widget tests for UI components
   - Integration tests for critical flows

4. **Documentation**
   - Inline comments for complex logic
   - README files in each module
   - API documentation with examples

---

## 🧪 Testing

### Backend Testing

#### Run Test Suite
```bash
cd heart_disease_api
python test_api.py
```

#### Manual Testing with Swagger UI
1. Start backend: `python run.py`
2. Open browser: `http://localhost:8000/docs`
3. Click "Try it out" on POST /api/predict
4. Enter test data
5. Execute and verify response

#### Unit Tests (Future)
```bash
pytest tests/
```

### Flutter Testing

#### Unit Tests
```bash
flutter test
```

#### Widget Tests
```bash
flutter test test/widget_test.dart
```

#### Integration Tests (Future)
```bash
flutter drive --target=test_driver/app.dart
```

### Test Cases

#### Backend Test Cases
- ✅ Root endpoint returns correct metadata
- ✅ Health check returns healthy status
- ✅ Prediction with valid data returns result
- ✅ Prediction with invalid data returns 422
- ✅ Risk level correctly categorized

#### Flutter Test Cases
- ✅ Splash screen navigates after delay
- ✅ Form validation works correctly
- ✅ Assessment submission triggers API call
- ✅ Results display correctly
- ✅ History persists assessments
- ✅ Profile updates save successfully

---

## 🚢 Deployment Guide

### Backend Deployment

#### Option 1: Docker (Recommended)

**Create Dockerfile:**
```dockerfile
FROM python:3.10-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 8000

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
```

**Build and Run:**
```bash
docker build -t heart-disease-api .
docker run -p 8000:8000 heart-disease-api
```

#### Option 2: Cloud Platforms

**Heroku:**
```bash
heroku create heart-disease-api
git push heroku main
```

**AWS EC2:**
1. Launch EC2 instance (Ubuntu)
2. Install Python 3.10+
3. Clone repository
4. Install dependencies
5. Run with systemd service

**Google Cloud Run:**
```bash
gcloud run deploy heart-disease-api \
  --source . \
  --platform managed \
  --region us-central1
```

#### Option 3: VPS (DigitalOcean, Linode)
```bash
# Install dependencies
sudo apt update
sudo apt install python3-pip python3-venv nginx

# Setup application
cd /var/www/heart_disease_api
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Configure Nginx reverse proxy
sudo nano /etc/nginx/sites-available/api

# Start with systemd
sudo systemctl start heart-disease-api
sudo systemctl enable heart-disease-api
```

### Flutter Deployment

#### Android APK Build

**Debug APK:**
```bash
flutter build apk --debug
```

**Release APK:**
```bash
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

**Split APKs by ABI:**
```bash
flutter build apk --split-per-abi --release
```

#### Android App Bundle (Google Play)

```bash
flutter build appbundle --release
# Output: build/app/outputs/bundle/release/app-release.aab
```

**Upload to Google Play Console:**
1. Create developer account
2. Create app listing
3. Upload AAB file
4. Complete store listing
5. Submit for review

#### iOS Build (macOS only)

**Debug Build:**
```bash
flutter build ios --debug
```

**Release Build:**
```bash
flutter build ios --release
```

**App Store Upload:**
1. Open Xcode: `open ios/Runner.xcworkspace`
2. Select "Any iOS Device" target
3. Product → Archive
4. Upload to App Store Connect

### Update API Endpoint for Production

```dart
// lib/datasource/datafrom_remote_source.dart
const String API_BASE_URL = 'https://api.yourdomain.com';

Future<PredictionResponse> predict({required FormData formData}) async {
  final response = await _dio.post(
    '$API_BASE_URL/api/predict',
    // ...
  );
}
```

### Environment Configuration

**Create .env file:**
```
# Backend
API_HOST=0.0.0.0
API_PORT=8000
CORS_ORIGINS=https://yourdomain.com

# Flutter
API_BASE_URL=https://api.yourdomain.com
FIREBASE_API_KEY=your_key_here
```

---

## 🐛 Troubleshooting

### Common Issues

#### 1. Backend Won't Start

**Error:** `FileNotFoundError: Model file not found`

**Solution:**
```bash
# Verify model files exist
ls -la heart_disease_api/artifacts/
# Should show:
# - heart-disease-prediction-model.pkl
# - scaler.pkl

# If missing, train model or obtain files
```

#### 2. Flutter Can't Connect to API

**Error:** `DioException: Connection refused`

**Solution:**
- Verify backend is running: `curl http://localhost:8000/health`
- Check API endpoint URL in Flutter code
- Use local IP (not localhost) for physical device testing
- Ensure device and computer are on same network
- Check firewall settings

#### 3. Firebase Configuration Error

**Error:** `MissingPluginException: No implementation found for FirebaseAuth`

**Solution:**
```bash
flutter clean
flutter pub get
cd android && ./gradlew clean
cd .. && flutter run
```

#### 4. Floor Database Error

**Error:** `DatabaseOpenException: Unable to open database`

**Solution:**
```bash
# Regenerate Floor code
flutter packages pub run build_runner build --delete-conflicting-outputs
```

#### 5. Google Sign-In Not Working

**Solution:**
1. Verify SHA-1 fingerprint in Firebase console
2. Download latest `google-services.json`
3. Clean and rebuild:
   ```bash
   flutter clean
   cd android && ./gradlew clean
   cd .. && flutter run
   ```

#### 6. Model Prediction Errors

**Error:** `ValueError: Feature mismatch`

**Solution:**
- Verify feature order matches training data
- Check data types (int vs float)
- Ensure all required fields are provided
- Validate input ranges

### Debugging Tips

#### Backend Debugging
```python
# Add print statements in predictor.py
print(f"Input features: {features}")
print(f"Scaled features: {scaled_features}")
print(f"Prediction: {prediction_class}")
```

#### Flutter Debugging
```dart
// Add debug prints in BLoC
print('Form data: ${event.formData}');
print('API response: $result');

// Use Flutter DevTools
flutter run --observatory-port=8888
```

### Performance Optimization

#### Backend
- Use async/await for I/O operations
- Implement caching for repeated predictions
- Use connection pooling
- Enable gzip compression

#### Flutter
- Use const constructors where possible
- Implement lazy loading for lists
- Optimize image assets
- Use `ListView.builder` for long lists
- Profile with Flutter DevTools

---

## 📈 Future Enhancements

### Planned Features

1. **Backend**
   - [ ] Authentication & authorization
   - [ ] Rate limiting
   - [ ] Model versioning
   - [ ] A/B testing different models
   - [ ] Prediction history storage
   - [ ] Analytics dashboard

2. **Flutter App**
   - [ ] Offline mode with queue sync
   - [ ] Push notifications for health reminders
   - [ ] PDF report generation
   - [ ] Data visualization charts
   - [ ] Wearable device integration
   - [ ] Multi-language support
   - [ ] Dark mode theme
   - [ ] Accessibility improvements

3. **Machine Learning**
   - [ ] Retrain model with more data
   - [ ] Experiment with different algorithms
   - [ ] Ensemble models for better accuracy
   - [ ] Explainable AI (SHAP values)
   - [ ] Feature importance visualization

4. **DevOps**
   - [ ] CI/CD pipeline
   - [ ] Automated testing
   - [ ] Load testing
   - [ ] Monitoring & logging
   - [ ] Auto-scaling

---

## 📞 Support & Contact

### Documentation
- **README**: General overview
- **SETUP**: Installation guide
- **PROJECT_SUMMARY**: Implementation summary
- **This Document**: Comprehensive reference

### Resources
- **Flutter Docs**: https://docs.flutter.dev/
- **FastAPI Docs**: https://fastapi.tiangolo.com/
- **Firebase Docs**: https://firebase.google.com/docs
- **scikit-learn Docs**: https://scikit-learn.org/

### Project Repository
```
Location: https://github.com/Kawser-Miah/heart_disease_prediction
```

---

## 📝 Version History

### Version 1.0.0 (Current)
- ✅ Full-stack implementation complete
- ✅ Flutter mobile app with 12 screens
- ✅ FastAPI backend with ML model
- ✅ Firebase authentication integration
- ✅ Local database with Floor
- ✅ BLoC state management
- ✅ Comprehensive documentation

### Future Versions
- v1.1.0: Offline mode, push notifications
- v1.2.0: Advanced analytics, PDF reports
- v2.0.0: Multi-language support, wearable integration

---

## 📄 License

This project is proprietary software. All rights reserved.

---

## 🙏 Acknowledgments

- **Flutter Team**: For the amazing cross-platform framework
- **FastAPI**: For the modern, fast web framework
- **scikit-learn**: For machine learning capabilities
- **Firebase**: For backend services
- **Community**: For open-source packages and resources

---

**Last Updated:** December 30, 2025  
**Maintained By:** Development Team  
**Project Status:** ✅ Production Ready

---

## 📊 Quick Reference

### Important Commands

```bash
# Backend
cd heart_disease_api
python run.py                    # Start server
python test_api.py               # Test API

# Flutter
flutter pub get                  # Install dependencies
flutter run                      # Run app
flutter build apk --release      # Build APK
flutter test                     # Run tests
flutter doctor                   # Check setup

# Database
flutter packages pub run build_runner build  # Generate Floor code

# Firebase
flutterfire configure           # Configure Firebase
```

### Important Files

- `lib/main.dart` - App entry point
- `lib/datasource/datafrom_remote_source.dart` - API endpoint
- `heart_disease_api/app/main.py` - Backend entry point
- `heart_disease_api/app/core/config.py` - Backend config
- `pubspec.yaml` - Flutter dependencies
- `requirements.txt` - Python dependencies

### Contact Configuration Points

1. **API Endpoint**: `lib/datasource/datafrom_remote_source.dart`
2. **Firebase Config**: `lib/firebase_options.dart`
3. **Backend Port**: `heart_disease_api/app/core/config.py`
4. **CORS Settings**: `heart_disease_api/app/main.py`

---

**End of Documentation** 📖
