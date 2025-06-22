# Dart Tracker App

A modern Flutter application for automated dart tracking and scoring. This app provides real-time dart tracking using the device camera and maintains a detailed scoreboard of your game.

## Features

- 📱 Modern, clean UI with Material 3 design
- 📸 Real-time camera tracking for darts
- 🎯 Round and throw tracking
- 📊 Detailed scoreboard with round-by-round breakdown
- 🔄 Easy navigation between tracking and scoring screens

## Getting Started

### Prerequisites

- Flutter SDK (latest version)
- Android Studio or VS Code with Flutter extension
- An Android or iOS device/emulator

### Installation

1. Clone the repository
```bash
git clone https://github.com/YOUR_USERNAME/dart-tracker-app.git
```

2. Navigate to the project directory
```bash
cd dart-tracker-app
```

3. Install dependencies
```bash
flutter pub get
```

4. Run the app
```bash
flutter run
```

## Project Structure

```
lib/
├── main.dart                  # App entry point
├── theme/
│   └── app_theme.dart        # Custom theme configuration
└── screens/
    ├── home_screen.dart      # Main screen with bottom navigation
    ├── dart_tracking_screen.dart  # Camera view for tracking darts
    └── scoreboard_screen.dart     # Score display screen
```

## Tech Stack

- Flutter
- Dart
- Camera Plugin
- Google Fonts

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.
