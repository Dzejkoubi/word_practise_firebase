import 'dart:async';
import 'package:flutter/material.dart';
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
    return MaterialApp();
  }
}
