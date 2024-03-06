import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/main.dart';
import 'dart:math';

Future<int> getCountOfWords() async {
  final ref = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref()
      .child("words");

  final snapshot = await ref.get();
  if (snapshot.exists) {
    List<dynamic> words = snapshot.value as List<dynamic>;
    return words.length;
  } else {
    return 0;
  }
}

Future<int> getWordNumber() async {
  int countOfWords = await getCountOfWords();
  if (countOfWords == 0) {
    return 0;
  } else {
    int randomNumber = Random().nextInt(max(countOfWords, 1));
    return randomNumber;
  }
}

Future<List<int>> getCountOfEnCzWords() async {
  int countOfWords;
  try {
    countOfWords = await getWordNumber(); // Correctly awaiting the Future<int>
  } catch (e) {
    print("Error getting word number: $e");
    return [0, 0]; // Handle the error or return.
  }

  final enRef = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref()
      .child("words/$countOfWords/english");

  final czRef = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref()
      .child("words/$countOfWords/czech");

  final enSnapshot = await enRef.get();
  final czSnapshot = await czRef.get();

  if (enSnapshot.exists && czSnapshot.exists) {
    List<dynamic> englishWords = enSnapshot.value as List<dynamic> ?? [];
    List<dynamic> czechWords = czSnapshot.value as List<dynamic> ?? [];
    return [
      englishWords.length,
      czechWords.length
    ]; // Correctly returning counts as lists
  } else {
    return [0, 0]; // Returning 0 for both if either snapshot doesn't exist.
  }
}
