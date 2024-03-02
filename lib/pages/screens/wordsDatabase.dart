import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class wordsDatabase extends StatefulWidget {
  const wordsDatabase({super.key});

  @override
  State<wordsDatabase> createState() => _wordsDatabaseState();
}

class _wordsDatabaseState extends State<wordsDatabase> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference ref = FirebaseDatabase.instance.ref();

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
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text("Your Words"),
                ElevatedButton(
                  onPressed: () {},
                  child: Text("Get Data"),
                ),
              ],
            ),
          ),
        ));
  }
}
