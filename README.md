# AI-Based Public Transport Navigator

A Flutter app that optimizes public transport routes using AI (Dijkstra’s algorithm), displays routes on an OpenStreetMap (`flutter_map`), and stores user preferences and route history in Firebase Firestore. Features a dark-themed UI with `GoogleFonts.poppins` and a speed-vs-cost preference slider.
![dijisktra](https://github.com/user-attachments/assets/b0a9aaab-0426-4ea5-a4e9-5ef156261740)

## Features
- **Route Optimization**: AI-driven route calculation based on speed and cost preferences.
- **Interactive Map**: Displays routes with polylines on OpenStreetMap.
- **Firebase Integration**: Saves routes and preferences to Firestore.
- **Responsive UI**: Dark theme, animations, and intuitive navigation.

## Setup Instructions
1. **Clone the Repository**:
   ```bash
   git clone https://github.com/your-username/transport_navigator.git
   cd transport_navigator
   ```
2. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
3. **Add Firebase Configuration**:
   - Download `google-services.json` from Firebase Console (Project Settings > Your Apps > Android).
   - Place it in `android/app/`.
4. **Run the App**:
   ```bash
   flutter run
   ```
   Ensure an emulator (e.g., `sdk gphone64 x86 64`) or physical device is connected.

## Requirements
- Flutter 3.0+
- Dart 2.17+
- JDK 11
- Android SDK 34
- Firebase project with Firestore enabled

## Troubleshooting
- **Gradle Issues**: Ensure `JAVA_HOME` is set to your JDK path (e.g., `C:\Program Files\Java\jdk-11`).
- **Firebase**: Verify `google-services.json` is correctly configured.
- **Map**: Ensure internet permissions are set in `android/app/src/main/AndroidManifest.xml`.

## License
MIT License
