import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';
import 'package:word_practise_firebase/global_functions.dart';

class YourWords extends StatefulWidget {
  const YourWords({super.key});

  @override
  State<YourWords> createState() => _YourWordsState();
}

class _YourWordsState extends State<YourWords> {
  @override
  void initState() {
    super.initState();
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
          Expanded(
            child: WordsScreen(),
          ),
        ],
      ),
    );
  }
}

class WordPair {
  final List<String> czech;
  final List<String> english;

  WordPair({required this.czech, required this.english});

  factory WordPair.fromMap(Map<dynamic, dynamic> data) {
    return WordPair(
      czech: List<String>.from(data['czech']),
      english: List<String>.from(data['english']),
    );
  }
}

class WordsScreen extends StatefulWidget {
  const WordsScreen({super.key});

  @override
  _WordsScreenState createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  final dbRef = FirebaseDatabase.instance.ref();
  List<WordPair> words = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    DataSnapshot snapshot = await dbRef.child('words').get();
    List<WordPair> newWords = [];
    if (snapshot.exists && snapshot.value != null) {
      List data = snapshot.value as List;
      for (var value in data) {
        if (value != null && value is Map) {
          newWords.add(WordPair.fromMap(Map<dynamic, dynamic>.from(value)));
        }
      }
      setState(() {
        words = newWords;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Word Pairs"),
      ),
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(words[index].english.join(", ")),
            subtitle: Text(words[index].czech.join(", ")),
          );
        },
      ),
    );
  }
}
