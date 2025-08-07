# Phantom Wallet Flutter App

A Flutter Android application demonstrating Phantom wallet connection functionality for Solana blockchain.

## Features

- 🔗 Phantom Wallet connection simulation
- 📱 Clean Material Design UI
- 🎨 Purple theme matching Phantom branding
- 🔗 Direct link to download Phantom Wallet
- 💼 Wallet address display
- 🔄 Connect/disconnect functionality

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0+
- Android SDK
- Android Studio or VS Code

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd phantom_wallet_app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building APK

To build a release APK:
```bash
flutter build apk --release
```

## About

This is a demo application showcasing the basic structure for integrating with Phantom Wallet on Android. The current implementation shows a simulation of wallet connection for demonstration purposes.

For production use, you would need to:
- Implement actual Phantom Wallet SDK integration
- Add proper error handling
- Include security measures
- Set up proper deep link handling

## Architecture

- `lib/main.dart` - Main application entry point and UI
- `android/` - Android platform-specific configuration
- `pubspec.yaml` - Project dependencies and configuration

## Dependencies

- `flutter` - Flutter SDK
- `url_launcher` - For launching external URLs
- `cupertino_icons` - iOS-style icons

## License

This project is for demonstration purposes.