import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/firebase_options.dart';
import 'package:word_practise_firebase/pages/screens/game.dart';
import 'package:word_practise_firebase/pages/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: game(),
    );
  }
}