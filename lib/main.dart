import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';
import 'package:word_practise_firebase/firebase_options.dart';
import 'package:word_practise_firebase/pages/practise.dart';
import 'package:word_practise_firebase/pages/user_auth/user_centre.dart';
import 'package:word_practise_firebase/pages/your_words.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  //Navigation bar index
  int _selectedIndex = 2;

  final List<Widget> _navBarWidgets = <Widget>[
    const YourWords(),
    const FuturePractiseLoader(),
    const UserCentre(),
  ];

  void navBarHandler(int index) {
    setState(() {
      _selectedIndex = index; // Updating the current tab index on tap
    });
  }

  final wordsRef = FirebaseDatabase.instance.ref().child("words");

  @override
  Widget build(BuildContext context) {
    const navBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.list),
        label: 'Your Words',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.play_arrow_rounded),
        label: 'Practise',
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.person_rounded),
        label: 'User',
      ),
    ];
    const pageTitles = <String>[
      'Your Words List',
      'Word Practise',
      'User Centre',
    ];
    return MaterialApp(
        title: "Word Practise",
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
            title: PageTitle(text: pageTitles[_selectedIndex]),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  // Navigate to the user profile page
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: _navBarWidgets[_selectedIndex],
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: navBarItems,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.amber[800],
            onTap: navBarHandler,
          ),
        ));
  }
}

//Game screen widget
//Game loader widget to load the game screen after Firebase initialization
//Path: lib/pages/game.dart
class FuturePractiseLoader extends StatefulWidget {
  const FuturePractiseLoader({super.key});

  @override
  State<FuturePractiseLoader> createState() => FuturePractiseLoaderState();
}

class FuturePractiseLoaderState extends State<FuturePractiseLoader> {
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
                child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                color: Colors.amber,
              ),
              Text("Loading game...",
                  style: TextStyle(fontSize: 15, color: Colors.black)),
            ],
          ),
        )));
      },
    );
  }
}
