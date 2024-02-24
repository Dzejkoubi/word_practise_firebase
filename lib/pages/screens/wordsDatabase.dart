//General imports
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Word converter imports
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import "../services/wordsConverter.dart";

class wordsDatabase extends StatefulWidget {
  const wordsDatabase({super.key});
  @override
  State<wordsDatabase> createState() => _wordsDatabaseState();
}

void printConvertedJson() async {
  final String response = await rootBundle.loadString('assets/words.json');
  final data = json.decode(response);
  final wordList = WordList.fromJson(data);

  print(wordList.words);
}

class _wordsDatabaseState extends State<wordsDatabase> {
  Future<WordList> loadWordList() async {
    final String response = await rootBundle.loadString('assets/words.json');
    final data = json.decode(response);

    return WordList.fromJson(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Your Words",
            style: TextStyle(
              color: Colors.blue[200],
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo[600],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: Column(
            children: [
              TextButton.icon(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color?>(Colors.blue[200]),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            side: BorderSide(
                                color: Colors.blue[900]!, width: 2.0))),
                  ),
                  onPressed: () {},
                  icon: Icon(
                    Icons.add,
                    color: Colors.blue[900],
                  ),
                  label: Text(
                    'Add Words',
                    style: TextStyle(
                      color: Colors.blue[900],
                    ),
                  )),
              Expanded(
                child: FutureBuilder<WordList>(
                  future: loadWordList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.words.length,
                        itemBuilder: (context, index) {
                          final wordEntry = snapshot.data!.words[index];
                          //List item start
                          return ListTile(
                            title: Text('Czech: ${wordEntry.czech.join(', ')}'),
                            subtitle: Text(
                                'English: ${wordEntry.english.join(', ')}'),
                            trailing: Text(wordEntry.hint?.join(', ') ?? ''),
                          );
                          //List item end
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text("Error: ${snapshot.error}"),
                      );
                    } else {
                      // Loading
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
