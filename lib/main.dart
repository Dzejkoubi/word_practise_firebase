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
    // real Time values
    //Game
    //Game values and variables
    int wordsCount = 0;
    int wordNumber;
    String foreignWord;
    Future enWords;
    Future czWords;
    String englishWords;
    String czechWords;
    int englishWordsLength;
    int czechWordsLength;
    //References to firebase database
    final wordsRef = ref.child("words");
    //Game functions
    //1. Gets total number of words in the database.
    Future<int> getCountOfWords() async {
      final snapshot = await wordsRef.get();
      if (snapshot.exists) {
        List<dynamic> words = snapshot.value as List<dynamic>;
        return wordsCount = words.length;
      } else {
        return 0;
      }
    }

    void game() async {
      wordsCount =
          await getCountOfWords(); //gets the total number of words in the database.
      wordNumber = Random().nextInt(
          max(wordsCount, 1)); //selects a random word number from the database.
      final enWords = wordsRef.child("$wordNumber/english").get();
      final czWords = wordsRef.child("$wordNumber/czech").get();
      List<dynamic> englishWords = (await enWords).value as List<dynamic> ?? [];
      List<dynamic> czechWords = (await czWords).value as List<dynamic> ?? [];
      englishWordsLength = englishWords.length - 1;
      czechWordsLength = czechWords.length - 1;
      int czOrEn;
// Check both lengths directly from the list sizes
      englishWordsLength = englishWords.length;
      czechWordsLength = czechWords.length;

// Determine if we should attempt to select from English or Czech lists
      if (englishWordsLength > 0 && czechWordsLength > 0) {
        czOrEn = Random()
            .nextInt(2); // Both have words, choose randomly between them
      } else if (englishWordsLength > 0) {
        czOrEn = 0; // Only English words available
      } else if (czechWordsLength > 0) {
        czOrEn = 1; // Only Czech words available
      } else {
        // Handle the case where both lists are empty
        foreignWord = ""; // No words available
        print(foreignWord);
        return;
      }

// Now, select a word based on the updated logic
      if (czOrEn == 0) {
        foreignWord = englishWords[Random().nextInt(englishWordsLength)];
      } else {
        // This implies czOrEn == 1 and czechWordsLength > 0
        foreignWord = czechWords[Random().nextInt(czechWordsLength)];
      }

      print(foreignWord);
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          children: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo[300],
              ),
              onPressed: () {},
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
              "Enter the translation of the word below:",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 200,
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
                const SizedBox(width: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[300],
                  ),
                  onPressed: () async {
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
            )
          ],
        ),
      ),
    );
  }
}
