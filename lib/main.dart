//Core packages
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:word_practise_firebase/pages/game.dart';
//Packages
import 'dart:math';

//Pages
import 'firebase_options.dart';
import 'package:word_practise_firebase/components/helperWidgets.dart';
//Widgets
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      home: Game(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //Run the game function when the app starts
  @override
  void initState() {
    super.initState();
    game();
  }

  //Prints the values of the variables
  void printValues() {
    print(
        "Word count: $wordsCount \n Word number: $wordNumber \n English words: $englishWords \n Czech words: $czechWords \n English words length: $englishWordsLength \n Czech words length: $czechWordsLength \n Foreign word: $foreignWord \n CZ or EN: $czOrEn \n");
  }

  //Text field controller
  final _textFieldInput = TextEditingController();

  //Firebase variables
  final Future<FirebaseApp> _fApp = Firebase.initializeApp();
  final ref = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref();

  //Game function variables
  int wordsCount = 0;
  int wordNumber = 0;
  String foreignWord = "";
  List<dynamic> englishWords = [];
  List<dynamic> czechWords = [];
  int englishWordsLength = 0;
  int czechWordsLength = 0;
  int czOrEn = 0;

  //Other variables
  String afterSubmitText = "";
  String hintText = "hinted word here";
  int showedWords = 0;

  //Game function
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

  //Check if the answer is correct
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

  int _selectedIndex = 1;

  static const List<Widget> _pages = <Widget>[
    Text('Your Words'),
    MyApp(),
    Text('User Centre'),
  ];

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget navbar() {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.list),
          label: 'Your Words',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.play_arrow),
          label: 'Practise',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'User Centre',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onNavItemTapped,
      iconSize: 35,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      bottomNavigationBar: navbar(),
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
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: Column(
        children: <Widget>[
          const Text(
            "Translate the word:", //Word to translate
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Text(
            foreignWord,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          addVerticalSpace(15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  width: 250,
                  height: 70,
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: _textFieldInput,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      suffix: IconButton(
                          icon: const Icon(Icons.clear),
                          onPressed: () {
                            _textFieldInput.clear();
                          }),
                      labelText: 'Translation',
                      labelStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 20,
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  )),
              addHorizontalSpace(15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo[300],
                ),
                onPressed: () async {
                  checkAnswer();
                  if (checkAnswer() == true) {
                    print("Correct answer");
                    setState(() {
                      afterSubmitText = "Correct answer";
                    });
                    if (czOrEn == 0 && czechWordsLength > 1) {
                      setState(
                        () {
                          List<String> otherAnswers =
                              List<String>.from(czechWords);
                          otherAnswers.remove(_textFieldInput.text);
                          afterSubmitText =
                              "Další správné odpovědi byly: \n${otherAnswers.join(" nebo ")} ";
                          print(otherAnswers.join(" nebo "));
                        },
                      );
                    } else if (czOrEn == 1 && englishWordsLength > 1) {
                      setState(
                        () {
                          List<String> otherAnswers =
                              List<String>.from(englishWords);
                          otherAnswers.remove(_textFieldInput.text);
                          afterSubmitText =
                              "Další správné odpovědi byly: \n${otherAnswers.join(" or ")} ";
                          print(afterSubmitText);
                        },
                      );
                    }
                  } else {
                    print("Wrong answer");
                    if (czOrEn == 0) {
                      setState(() {
                        afterSubmitText =
                            "$foreignWord = ${czechWords.join(" nebo ")} ";
                      });
                    } else {
                      setState(() {
                        afterSubmitText =
                            "$foreignWord = ${englishWords.join(" or ")} ";
                      });
                    }
                  }
                  game();
                  _textFieldInput.clear();
                  setState(() {
                    showedWords = 0;
                    hintText = "hinted word here";
                  });
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
          ),
          addVerticalSpace(15),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      showedWords++;
                      setState(() {
                        if (czOrEn == 0) {
                          String snapshot = "";
                          setState(() {
                            hintText = snapshot =
                                czechWords[Random().nextInt(czechWordsLength)]
                                    .substring(0, showedWords);
                            ;
                          });
                        } else {
                          String snapshot = "";
                          setState(() {
                            hintText = snapshot = englishWords[
                                    Random().nextInt(englishWordsLength)]
                                .substring(0, showedWords);
                            ;
                          });
                        }
                      });
                    },
                    child: Row(
                      children: [
                        Text("hint"),
                        Icon(Icons.question_mark_rounded)
                      ],
                    )),
                addHorizontalSpace(40),
                Text(hintText, style: const TextStyle(fontSize: 20)),
              ],
            ),
          ),
          ElevatedButton(
              child: Text("Random ASSbutton"),
              onPressed: () {
                printValues();
                _textFieldInput.clear();
              }),
          addVerticalSpace(15),
          Text(
            afterSubmitText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      )),
    );
  }
}
