import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

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
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                child: const ImportantText(text: "English"),
              ),
              addHorizontalSpace(80),
              Container(
                padding: const EdgeInsets.all(20),
                child: const ImportantText(text: "Czech"),
              ),
              addHorizontalSpace(5),
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                          height: 500,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(20),
                                child: ImportantText(text: "Add new word pair"),
                              ),
                              const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: BasicTextField(
                                    hintText: "Czech",
                                  )),
                              const Padding(
                                  padding: EdgeInsets.all(20),
                                  child: BasicTextField(
                                    hintText: "Czech",
                                  )),
                              IconButtonStyle(
                                icon: Icons.image_rounded,
                                text: "Upload image",
                                onPressed: () {},
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: ImportantButton(
                                  text: "Add Word",
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ));
                    },
                  );
                },
                icon: const Icon(Icons.add_rounded),
              )
            ],
          ),
          const Divider(
            height: 20,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: WordsScreen(),
            ),
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
      body: ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(words[index].english.join(", ")),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(words[index].czech.join(", ")),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {}, icon: const Icon(Icons.image_rounded)),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      dbRef.child('words').remove();
                      fetchData();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

// Text(words[index].english.join(", ")),
// Text(words[index].czech.join(", ")),
