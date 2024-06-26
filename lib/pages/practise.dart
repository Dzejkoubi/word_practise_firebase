import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/general_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
//Firebase

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => GameState();
}

class GameState extends State<Game> {
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

  //Firebase variables
  final DatabaseReference ref = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref();

  //Game function variables
  int wordsCount = 0;
  int wordNumber = 0;
  String foreignWord = "";
  List<dynamic> englishWords = [];
  List<dynamic> czechWords = [];
  String picture = "";
  int englishWordsLength = 0;
  int czechWordsLength = 0;
  int czOrEn = 0;

  final _textFieldInput = TextEditingController();

  //Checking the answer
  String afterSubmitText = "";
  String hintText = "";
  int showedWords = 0;
  String selectedWord = "";
  bool isWordSelected = false;

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

  //Runs when check button is pressed

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
                "Správně také bylo: \n${otherAnswers.join(" nebo ")} ";
            print(otherAnswers.join(" nebo "));
          },
        );
      } else if (czOrEn == 1 && englishWordsLength > 1) {
        setState(
          () {
            List<String> otherAnswers = List<String>.from(englishWords);
            otherAnswers.remove(_textFieldInput.text);
            afterSubmitText =
                "Správně také bylo: \n${otherAnswers.join(" or ")} ";
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
      hintText = "";
      isWordSelected = false;
    });
  }

  //Hint function

  void hint() {
    setState(() {
      if (!isWordSelected) {
        if (czOrEn == 0 && czechWords.isNotEmpty) {
          selectedWord = czechWords[Random().nextInt(czechWords.length)];
          isWordSelected = true;
        } else if (englishWords.isNotEmpty) {
          selectedWord = englishWords[Random().nextInt(englishWords.length)];
          isWordSelected = true;
        }
      }

      if (showedWords < selectedWord.length) {
        showedWords++;
        hintText = selectedWord.substring(0, showedWords);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(children: <Widget>[
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
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://scontent-ams4-1.xx.fbcdn.net/v/t39.30808-6/299955693_394909949440211_4594910037695120492_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=5f2048&_nc_ohc=HdjkSA6TQuMQ7kNvgGtgbWf&_nc_ht=scontent-ams4-1.xx&oh=00_AfBJI3ZB4znHdtmhsswJNBFopWHmKdmtpQtghCtUhUYOGw&oe=663EF5C1',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              print('Error loading image: $error');
              return const Center(
                child: Text('No picture available'),
              );
            },
          ),
        ),
      ),

      addVerticalSpace(20),
      ImportantText(text: foreignWord),
      addVerticalSpace(20),

      //Text field for the user to enter the word

      Container(
        height: 70,
        width: 320,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            boxShadow: AppShadows.customBoxShadow,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black, width: 1.5)),
        alignment: Alignment.center,
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
          onSubmitted: (value) {
            checkButton();
          },
          autofocus: true,
          focusNode: FocusNode()..requestFocus(),
        ),
      ),
      addVerticalSpace(20),

      //Submit button

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ValueListenableBuilder(
            valueListenable: _textFieldInput,
            builder:
                (BuildContext context, TextEditingValue value, Widget? child) {
              return BasicElevatedButton(
                text: "Check",
                onPressed: value.text.isEmpty ? null : checkButton,
              );
            },
          ),
          addHorizontalSpace(20),
          BasicElevatedButton(text: "Hint", onPressed: hint),
        ],
      ),
      const SizedBox(height: 20),
      NormalText(text: hintText),
      BasicElevatedButton(text: "Print Values", onPressed: printValues),
      addVerticalSpace(15),
      ImportantText(text: afterSubmitText),
    ]));
  }
}
