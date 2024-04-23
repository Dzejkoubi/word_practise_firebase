import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/textStyles.dart';

class YourWords extends StatefulWidget {
  const YourWords({super.key});

  @override
  State<YourWords> createState() => _YourWordsState();
}

class _YourWordsState extends State<YourWords> {
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
                child: ImportantText(text: "Anglicky"),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ImportantText(text: "Česky"),
              ),
              Container(
                padding: const EdgeInsets.all(20),
                child: ImportantText(text: "Obrázek"),
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Word(
            english: "Happy",
            czech: "Šťastný",
          )
        ],
      ),
    );
  }
}

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
