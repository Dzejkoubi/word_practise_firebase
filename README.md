# Word Practice Game with Firebase Integration

## Overview

This Flutter project is a simple word practice game that integrates Firebase Realtime Database to fetch words for translation exercises. It demonstrates the use of Flutter for building a UI and Firebase for backend data management, offering a practical example of how to set up and use Firebase in a Flutter application.

## Project Setup

### Dependencies

- Flutter SDK
- Firebase
- Dart

### Core Packages

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
```

### Additional Files

- `firebase_options.dart`: Contains the Firebase project configuration.
- Pages and utilities:
  - `pages/screens/wordsDatabase.dart`
  - `utils/helper_widgets.dart`

## Main Function

The `main()` function initializes Firebase and runs the app:

```dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp(),));
}
```

## MyApp Class

`MyApp` is a `StatefulWidget` that initializes the application's UI.

### State Management

The `_MyAppState` class manages the state of the application, including:

- Firebase app initialization
- DatabaseReference setup
- Game logic variables
- Methods for game logic and UI interaction

### Firebase Integration

A Firebase Realtime Database is used to store and retrieve words for the game. The `game()` method asynchronously fetches words from Firebase, randomly selects a word, and updates the UI accordingly.

### UI Layout

The UI is built using Flutter widgets, structured as follows:

- AppBar: Displays the title of the application.
- FloatingActionButton: Navigates to a screen for adding new words to the database.
- TextField: Allows the user to enter their translation of the word.
- Buttons: Include a submit button for checking the translation and a hint button for showing partial words.

## Game Logic

The core game logic includes:

- Fetching words from Firebase and updating the state.
- Randomly selecting an English or Czech word for translation.
- Checking the user's answer against the correct translation.
- Providing hints by revealing letters of the word.

## Methods

- `game()`: Fetches words from Firebase, updates game variables, and refreshes the UI.
- `checkAnswer()`: Checks if the user's translation is correct.
- `printValues()`: Debug method for printing current game values to the console.
- `content()`: Builds the content of the app, including the translation exercise and controls.

## Usage

To run the application:

1. Ensure you have Flutter and Dart installed and set up.
2. Clone the project repository.
3. Navigate to the project directory in your terminal.
4. Run `flutter pub get` to install dependencies.
5. Run `flutter run` to build and launch the application on your device or emulator.

## Note

Ensure your Firebase project is set up correctly and the `firebase_options.dart` file is configured with your project's specific settings.
