import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/buttonStyles.dart';
import 'package:word_practise_firebase/components/styles/generalStyles.dart';
import 'package:word_practise_firebase/components/styles/textStyles.dart';
import 'package:word_practise_firebase/components/helperWidgets.dart';
//Firebase

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game> {
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

  void checkButton() async {
    checkAnswer();
    if (checkAnswer() == true) {
      print("Correct answer");
      setState(() {
        afterSubmitText = "Correct answer";
      });
      if (czOrEn == 0 && czechWordsLength > 1) {
        setState(
          () {
            List<String> otherAnswers = List<String>.from(czechWords);
            otherAnswers.remove(_textFieldInput.text);
            afterSubmitText =
                "Další správné odpovědi byly: \n${otherAnswers.join(" nebo ")} ";
            print(otherAnswers.join(" nebo "));
          },
        );
      } else if (czOrEn == 1 && englishWordsLength > 1) {
        setState(
          () {
            List<String> otherAnswers = List<String>.from(englishWords);
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
          afterSubmitText = "$foreignWord = ${czechWords.join(" nebo ")} ";
        });
      } else {
        setState(() {
          afterSubmitText = "$foreignWord = ${englishWords.join(" or ")} ";
        });
      }
    }
    game();
    _textFieldInput.clear();
    setState(() {
      showedWords = 0;
      hintText = "hinted word here";
    });
  }

  void hint() {
    showedWords++;
    setState(() {
      if (czOrEn == 0 && czechWordsLength > 0) {
        hintText = czechWords[Random().nextInt(czechWordsLength)]
            .substring(0, min(showedWords, czechWordsLength));
      } else if (englishWordsLength > 0) {
        hintText = englishWords[Random().nextInt(englishWordsLength)]
            .substring(0, min(showedWords, englishWordsLength));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Expanded(
            child: Center(
                child: Column(children: <Widget>[
      addVerticalSpace(120),

      //Picture for the word -- if no picture available, show a message

      Container(
          width: 320,
          height: 320,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1.5),
            boxShadow: AppShadows.customBoxShadow,
          ),
          child: const Center(
              child: NormalText(
            text: 'No picture available',
          ))),
      addVerticalSpace(20),
      ImportantText(text: foreignWord),
      addVerticalSpace(20),

      //Text field for the user to enter the word

      Container(
        width: 320,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: AppShadows.customBoxShadow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1.5)),
        child: TextField(
          controller: _textFieldInput,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Translation of the word',
            suffix: IconButton(
                icon: const Icon(Icons.clear),
                onPressed: () {
                  _textFieldInput.clear();
                }),
          ),
        ),
      ),
      addVerticalSpace(20),

      //Submit button

      BasicButton(onPressed: checkButton, text: "Check"),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ElevatedButton(
              onPressed: hint,
              child: Row(
                children: [
                  Text("hint"),
                  const Icon(Icons.question_mark_rounded)
                ],
              )),
          addHorizontalSpace(40),
          Text(hintText, style: const TextStyle(fontSize: 20)),
        ],
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
    ]))));
  }
}
