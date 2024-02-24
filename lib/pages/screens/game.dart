import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'wordsDatabase.dart';

class game extends StatefulWidget {
  @override
  State<game> createState() => _gameState();
}

class _gameState extends State<game> {
  final _textFieldInput = TextEditingController();
  Future<bool> aswerChecker() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => wordsDatabase()),
            );
          },
          label: Text('Add Words'),
          icon: Icon(Icons.add),
        ),
        appBar: AppBar(
          backgroundColor: Colors.indigo[700],
          title: const Text(
            'Word Practise',
            style: TextStyle(
              color: Color(0xFF90CAF9),
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo[300],
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Start game',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  "WORD",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 200,
                        height: 70,
                        child: TextField(
                          controller: _textFieldInput,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                          ),
                          decoration: InputDecoration(
                            suffix: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  _textFieldInput.clear();
                                }),
                            border: OutlineInputBorder(),
                            labelText: 'Translation',
                            labelStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 20,
                            ),
                            fillColor: Colors.white,
                            filled: true,
                          ),
                        )),
                    SizedBox(width: 10),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigo[300],
                      ),
                      onPressed: () {
                        setState(() {
                          print(_textFieldInput.text);
                        });
                      },
                      child: const Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
