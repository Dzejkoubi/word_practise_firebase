import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:word_practise_firebase/pages/screens/wordsDatabase.dart';
import 'firebase_options.dart';
import 'dart:math';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _textFieldInput = TextEditingController();
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  final ref = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref();
  //Variables
  int wordsCount = 0;
  int wordNumber = 0;
  String foreignWord = "";
  List<dynamic> englishWords = [];
  List<dynamic> czechWords = [];
  int englishWordsLength = 0;
  int czechWordsLength = 0;
  int czOrEn = 0;
  String worngAnswerShower = "";

  Future<void> game() async {
    final wordsRef = FirebaseDatabase.instance.ref().child("words");

    // Getting the total number of words in the database
    final snapshot = await wordsRef.get();
    if (snapshot.exists && snapshot.value is List) {
      List<dynamic> words = snapshot.value as List<dynamic>;

      // Use setState to update the state variables and refresh the UI
      setState(() {
        wordsCount = words.length;
        wordNumber = Random().nextInt(wordsCount);
      });

      final enWordSnapshot = await wordsRef.child("$wordNumber/english").get();
      final czWordSnapshot = await wordsRef.child("$wordNumber/czech").get();

      // Safe checks and updates with setState
      if (enWordSnapshot.exists && enWordSnapshot.value is List) {
        setState(() {
          englishWords = enWordSnapshot.value as List<dynamic>;
          englishWordsLength = englishWords.length;
        });
      }

      if (czWordSnapshot.exists && czWordSnapshot.value is List) {
        setState(() {
          czechWords = czWordSnapshot.value as List<dynamic>;
          czechWordsLength = czechWords.length;
        });
      }

      // Selects a word based on the available lists
      setState(() {
        if (englishWordsLength > 0 && czechWordsLength > 0) {
          czOrEn = Random()
              .nextInt(2); // Choose randomly between English and Czech words
          if (czOrEn == 0) {
            foreignWord = englishWords[Random().nextInt(englishWordsLength)];
          } else {
            foreignWord = czechWords[Random().nextInt(czechWordsLength)];
          }
        } else {
          print("No words available");
        }
      });
    } else {
      print("No words available");
    }
  }

  bool checkAnswer() {
    if (czOrEn == 0) {
      if (czechWords.contains(_textFieldInput.text)) {
        return true;
      } else {
        return false;
      }
    } else if (czOrEn == 1) {
      if (englishWords.contains(_textFieldInput.text)) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    game();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => wordsDatabase()),
          );
        },
        label: Text('Add Words'),
        icon: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.indigo[700],
        title: const Text(
          'Word Practise',
          style: TextStyle(
            color: Color(0xFF90CAF9),
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: _fApp,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return content();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        children: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[300],
            ),
            onPressed: () {
              game();
            },
            child: const Text(
              'Start game',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Enter the translation of the word below: $foreignWord",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 10),
          Container(
              width: 350,
              height: 70,
              child: TextField(
                controller: _textFieldInput,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                decoration: InputDecoration(
                  suffix: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        _textFieldInput.clear();
                      }),
                  border: OutlineInputBorder(),
                  labelText: 'Translation',
                  labelStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              )),
          const SizedBox(height: 10),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.indigo[300],
            ),
            onPressed: () async {
              checkAnswer();
              if (checkAnswer() == true) {
                print("Correct answer");
              } else {
                print("Wrong answer");
              }
              game();
            },
            child: const Text(
              'Submit',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      )),
    );
  }
}
