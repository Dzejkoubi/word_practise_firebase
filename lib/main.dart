//Core packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
//Packages
import 'dart:math';

//Pages
import 'firebase_options.dart';
import 'package:word_practise_firebase/pages/screens/wordsDatabase.dart';
import 'package:word_practise_firebase/utils/helper_widgets.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
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
  String hintText = "";
  int showedWords = 0;

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

  void printValues() {
    print(
        "Word count: $wordsCount \n Word number: $wordNumber \n English words: $englishWords \n Czech words: $czechWords \n English words length: $englishWordsLength \n Czech words length: $czechWordsLength \n Foreign word: $foreignWord \n CZ or EN: $czOrEn \n");
  }

  @override
  void initState() {
    super.initState();
    game();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Word Practise',
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
          const Text(
            "Translate the word:",
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
