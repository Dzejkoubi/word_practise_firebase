import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/firebase_options.dart';
import 'package:word_practise_firebase/pages/game.dart';
import 'package:word_practise_firebase/pages/userCenter.dart';
import 'package:word_practise_firebase/pages/wordDatabase.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  //Navigation bar index
  int _selectedIndex = 1;

  final List<Widget> _navBarWidgets = <Widget>[
    const WordsDatabases(),
    const FuntureGameLoader(),
    const UserCentre(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Updating the current tab index on tap
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Word Practise',
        home: Scaffold(
          body: FuntureGameLoader(),
          bottomNavigationBar: BottomNavigationBar(
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.book),
                label: 'Words',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.gamepad),
                label: 'Game',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: _onItemTapped,
          ),
        ));
  }
}

class FuntureGameLoader extends StatefulWidget {
  const FuntureGameLoader({super.key});

  @override
  State<FuntureGameLoader> createState() => FuntureGameLoaderState();
}

class FuntureGameLoaderState extends State<FuntureGameLoader> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
