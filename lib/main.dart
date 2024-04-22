import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; // Ensure you have this import if using FlutterFire CLI config
import 'package:word_practise_firebase/pages/game.dart'; // Ensure this is the correct path to your Game page

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Word Practice App',
      home: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          // Error catcher

          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error initializing Firebase"),
              ),
            );
          }

          // Show app game screen

          if (snapshot.connectionState == ConnectionState.done) {
            return const Game();
          }

          // Otherwise, show loading button

          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
