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
  void submitButton() {
    print("Button pressed");
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
      const ImportantText(text: "No word available"),
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
        child: const TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Translation of the word',
          ),
        ),
      ),
      addVerticalSpace(20),

      //Submit button

      BasicButton(onPressed: submitButton, text: "Submit"),
    ]))));
  }
}
