#!/bin/bash

# CardioCare Flutter - Quick Start Script
# This script helps you get the app running quickly

echo "🚀 CardioCare AI - Flutter Setup"
echo "================================"
echo ""

# Check if Flutter is installed
if ! command -v flutter &> /dev/null
then
    echo "❌ Flutter is not installed!"
    echo "📥 Please install Flutter first:"
    echo "   Visit: https://flutter.dev/docs/get-started/install"
    exit 1
fi

echo "✅ Flutter is installed"
flutter --version
echo ""

# Check Flutter doctor
echo "🔍 Checking Flutter environment..."
flutter doctor
echo ""

# Navigate to project directory
cd "$(dirname "$0")"

echo "📦 Installing dependencies..."
flutter pub get

if [ $? -eq 0 ]; then
    echo "✅ Dependencies installed successfully!"
    echo ""
else
    echo "❌ Failed to install dependencies"
    exit 1
fi

# Check for available devices
echo "📱 Checking for available devices..."
flutter devices
echo ""

# Ask user if they want to run the app
echo "🎯 Ready to run the app!"
echo ""
echo "Choose an option:"
echo "1) Run on default device"
echo "2) Run on Android emulator"
echo "3) Run on iOS simulator (macOS only)"
echo "4) List devices and exit"
echo "5) Exit without running"
echo ""
read -p "Enter your choice (1-5): " choice

case $choice in
    1)
        echo "🏃 Running on default device..."
        flutter run
        ;;
    2)
        echo "🤖 Running on Android emulator..."
        flutter run -d android
        ;;
    3)
        echo "🍎 Running on iOS simulator..."
        flutter run -d ios
        ;;
    4)
        echo "📱 Available devices:"
        flutter devices
        ;;
    5)
        echo "👋 Goodbye!"
        exit 0
        ;;
    *)
        echo "❌ Invalid choice!"
        exit 1
        ;;
esac

echo ""
echo "✨ Setup complete!"
echo "📚 For more information, see:"
echo "   - README.md - Project overview"
echo "   - SETUP.md - Detailed setup guide"
echo "   - PROJECT_SUMMARY.md - Complete implementation details"
