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
              color: Color(0xFF90CAF9),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.indigo[600],
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 0),
          child: FutureBuilder<WordList>(
            future: loadWordList(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                // Correctly use ListView.builder to display words in the list
                return ListView.builder(
                  itemCount:
                      snapshot.data!.words.length, // itemCount should be here
                  itemBuilder: (context, index) {
                    // itemBuilder starts here
                    final wordEntry = snapshot.data!.words[index];
                    return ListTile(
                      title: Text('Czech: ${wordEntry.czech.join(', ')}'),
                      subtitle:
                          Text('English: ${wordEntry.english.join(', ')}'),
                      trailing: Text(wordEntry.hint?.join(', ') ?? ''),
                    );
                  }, // itemBuilder ends here
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else {
                // By default, show a loading spinner.
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              // This is outside the FutureBuilder's builder function
            },
          ),
        ));
  }
}
