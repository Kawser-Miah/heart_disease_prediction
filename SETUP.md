# Flutter Installation & Setup Guide

## Step 1: Install Flutter SDK

### Windows
1. Download Flutter SDK from https://flutter.dev/docs/get-started/install/windows
2. Extract the zip file to a location (e.g., C:\src\flutter)
3. Add Flutter to PATH:
   - Open Control Panel → System → Advanced system settings
   - Click "Environment Variables"
   - Under "User variables", find "Path"
   - Add: C:\src\flutter\bin

### macOS
```bash
# Using Homebrew
brew install flutter

# Or download manually
cd ~/development
unzip ~/Downloads/flutter_macos_X.X.X-stable.zip
export PATH="$PATH:`pwd`/flutter/bin"
```

### Linux
```bash
sudo snap install flutter --classic

# Or manual installation
cd ~/development
tar xf ~/Downloads/flutter_linux_X.X.X-stable.tar.xz
export PATH="$PATH:`pwd`/flutter/bin"
```

## Step 2: Verify Installation

```bash
flutter doctor
```

This will show what needs to be installed.

## Step 3: Install Required Tools

### Android Studio (for Android development)
1. Download from https://developer.android.com/studio
2. Install Android SDK
3. Set up Android emulator

### Xcode (for iOS development - macOS only)
```bash
sudo xcodebuild -license
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

### VS Code (Recommended IDE)
1. Download from https://code.visualstudio.com/
2. Install Flutter extension
3. Install Dart extension

## Step 4: Set Up Project

```bash
# Navigate to project directory
cd /path/to/cardiocare_flutter

# Get dependencies
flutter pub get

# Verify project
flutter doctor -v
```

## Step 5: Run the App

### On Emulator/Simulator
```bash
# List available devices
flutter devices

# Run on specific device
flutter run -d <device-id>

# Run in debug mode (default)
flutter run

# Run in release mode (optimized)
flutter run --release
```

### On Physical Device

**Android:**
1. Enable Developer Options on your phone
2. Enable USB Debugging
3. Connect via USB
4. Run: `flutter run`

**iOS (macOS only):**
1. Connect iPhone via USB
2. Trust computer on device
3. Run: `flutter run`

## Common Commands

```bash
# Clean build
flutter clean

# Update dependencies
flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Build APK (Android)
flutter build apk

# Build iOS (macOS only)
flutter build ios

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
flutter format lib/
```

## Troubleshooting

### Issue: "Flutter command not found"
**Solution:** Add Flutter to your PATH

### Issue: "Android license status unknown"
**Solution:** Run `flutter doctor --android-licenses`

### Issue: "CocoaPods not installed" (macOS)
**Solution:** 
```bash
sudo gem install cocoapods
pod setup
```

### Issue: "Gradle build failed" (Android)
**Solution:**
```bash
cd android
./gradlew clean
cd ..
flutter clean
flutter pub get
```

### Issue: "Xcode build failed" (iOS)
**Solution:**
```bash
cd ios
pod install
cd ..
flutter clean
flutter run
```

## Development Tips

1. **Hot Reload**: Press `r` while app is running to hot reload
2. **Hot Restart**: Press `R` to hot restart
3. **Performance**: Use `flutter run --profile` for performance testing
4. **Debugging**: Use VS Code debugger or Android Studio debugger

## Additional Resources

- Flutter Documentation: https://docs.flutter.dev
- Flutter Packages: https://pub.dev
- Flutter Community: https://flutter.dev/community
- BLoC Documentation: https://bloclibrary.dev

## Project-Specific Setup

After installing Flutter, to run THIS project:

```bash
# 1. Navigate to project
cd cardiocare_flutter

# 2. Install dependencies
flutter pub get

# 3. Check for issues
flutter doctor

# 4. Run the app
flutter run
```

The app will start with a splash screen showing the CardioCare AI logo, then navigate to the home dashboard.

## IDE Configuration

### VS Code
Create `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "name": "Flutter",
      "type": "dart",
      "request": "launch",
      "program": "lib/main.dart"
    }
  ]
}
```

### Android Studio
1. Open project
2. Wait for Gradle sync
3. Click "Run" button
