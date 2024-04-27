import 'dart:ui';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/buttonStyles.dart';
import 'package:word_practise_firebase/components/styles/textStyles.dart';
import 'package:word_practise_firebase/components/helperWidgets.dart';

class YourWords extends StatefulWidget {
  const YourWords({super.key});

  @override
  State<YourWords> createState() => _YourWordsState();
}

class _YourWordsState extends State<YourWords> {
  List<dynamic> englishWords = [];
  List<dynamic> czechWords = [];
  int wordsCount = 0;

  Future<void> getWords() async {
    final wordsRef = FirebaseDatabase.instance.ref().child("words/0/english/0");

    final snapshot = await wordsRef.get();

    List<dynamic> words = snapshot.value as List<dynamic>;

    print("Snapshot: $words");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const ImportantText(text: "Anglicky"),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const ImportantText(text: "Česky"),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: const ImportantText(text: "Obrázek"),
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          FloatingActionButton(
              onPressed: getWords, child: const Text("Get words")),
        ],
      ),
    );
  }
}

//----------------------------------------------------

class Word extends StatefulWidget {
  Word({super.key, required this.english, required this.czech, this.image});

  final String english;
  final String czech;
  final Image? image;

  @override
  State<Word> createState() => _WordState();
}

class _WordState extends State<Word> {
  @override
  Widget build(BuildContext context) {
    return TestDatabaseView(widget: widget);
  }
}

class TestDatabaseView extends StatelessWidget {
  const TestDatabaseView({
    super.key,
    required this.widget,
  });

  final Word widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: widget.english,
              child: Text(widget.english),
            ),
            PopupMenuItem<String>(
              value: widget.english,
              child: Text(widget.english),
            ),
          ],
        ),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
            PopupMenuItem<String>(
              value: widget.english,
              child: Text(widget.english),
            ),
            PopupMenuItem<String>(
              value: widget.czech,
              child: Text(widget.czech),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
          width: 40,
          child: Image(
              image: AssetImage('assets/images/happy.webp'), fit: BoxFit.cover),
        )
      ],
    );
  }
}
