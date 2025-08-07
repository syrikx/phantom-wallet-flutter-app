# Phantom Wallet Flutter App

A Flutter Android application demonstrating **actual** Phantom wallet connection functionality for Solana blockchain using the official `phantom_wallet_connector` package.

## Features

- 🔗 **Real Phantom Wallet integration** using `phantom_wallet_connector`
- 🏗️ **Capsule SDK integration** for wallet infrastructure
- 📱 Clean Material Design UI
- 🎨 Purple theme matching Phantom branding
- 🔗 Direct link to download Phantom Wallet
- 💼 Wallet address display after successful connection
- 🔄 Connect/disconnect functionality
- 📲 Deep link support (`phantom-wallet-app://`)

## Getting Started

### Prerequisites

- Flutter SDK 3.0.0+
- Android SDK 35
- Android Studio or VS Code
- Capsule API key (for production use)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/syrikx/phantom-wallet-flutter-app.git
cd phantom-wallet-flutter-app
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

To build a debug APK:
```bash
flutter build apk --debug --android-skip-build-dependency-validation
```

To build a release APK:
```bash
flutter build apk --release
```

## Configuration

### Capsule SDK Setup
This app uses the Capsule SDK for wallet infrastructure. For production use:

1. Sign up for a Capsule account at [usecapsule.com](https://usecapsule.com)
2. Get your API key
3. Replace `'demo-api-key'` in `lib/main.dart` with your actual API key
4. Change environment from `Environment.sandbox` to `Environment.prod` for production

### Deep Link Configuration
The app is configured to handle deep links with the scheme `phantom-wallet-app://`. This is set up in:
- `android/app/src/main/AndroidManifest.xml` - Intent filter configuration

## Architecture

- `lib/main.dart` - Main application with Phantom wallet integration
- `android/` - Android platform configuration (SDK 35, Gradle 8.5, Kotlin 1.8.10)
- `pubspec.yaml` - Dependencies including phantom_wallet_connector

## Key Dependencies

- `phantom_wallet_connector: ^0.0.1-dev.1` - Official Phantom wallet connector
- `capsule: ^0.7.0` - Wallet infrastructure SDK
- `url_launcher: ^6.3.2` - For launching external URLs
- `pinenacl: ^0.6.0` - Cryptography library (overridden for compatibility)

## How It Works

1. **Initialization**: App initializes Capsule SDK with API key and environment
2. **Connection**: User taps "Connect to Phantom Wallet" which launches Phantom app
3. **Deep Link Return**: Phantom app returns to our app via deep link with wallet data
4. **Display**: Connected wallet address is displayed in the UI

## Production Considerations

For production deployment:
- ✅ Use proper Capsule API key
- ✅ Set production environment
- ✅ Implement proper error handling
- ✅ Add user authentication
- ✅ Include transaction signing functionality
- ✅ Add proper logging and monitoring

## Troubleshooting

### Build Issues
If you encounter build timeouts or Gradle issues:
```bash
flutter clean
flutter pub get
flutter build apk --debug --android-skip-build-dependency-validation
```

### pinenacl Compatibility
This project includes a dependency override for `pinenacl: ^0.6.0` to resolve compatibility issues with Flutter 3.8+.

## License

This project is for demonstration purposes. Check individual package licenses for production use.