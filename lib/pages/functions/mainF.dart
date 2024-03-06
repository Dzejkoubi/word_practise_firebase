import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/main.dart';
import 'dart:math';

//Gets total number of words in the database.
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

//Gets a random number for a word.
Future<int> getWordNumber() async {
  int countOfWords = await getCountOfWords();
  if (countOfWords != 0) {
    int randomNumber = Random().nextInt(max(countOfWords, 0));
    return randomNumber;
  } else {
    return 0;
  }
}

//Gets how many words are in the English and Czech lists for a random word.
Future<List<int>> getCountOfEnCzWords() async {
  int wordNumber;
  try {
    wordNumber = await getWordNumber(); // Correctly awaiting the Future<int>
  } catch (e) {
    print("Error getting word number: $e");
    return [0, 0]; // Handle the error or return.
  }
  print("Number of word: $wordNumber");

  final enRef = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref()
      .child("words/$wordNumber/english");

  final czRef = FirebaseDatabase(
          databaseURL:
              "https://word-pracise-cz-en-default-rtdb.europe-west1.firebasedatabase.app/")
      .ref()
      .child("words/$wordNumber/czech");

  final enWord = await enRef.get();
  final czWord = await czRef.get();

  if (enWord.exists && czWord.exists) {
    print("English: ${enWord.value}");
    print("Czech: ${czWord.value}");
    List<dynamic> englishWords = enWord.value as List<dynamic> ?? [];
    List<dynamic> enWords = czWord.value as List<dynamic> ?? [];
    return [
      englishWords.length - 1,
      enWords.length - 1,
    ]; // Correctly returning counts as lists
  } else {
    throw Exception(
        "Snapshot doesn't exist"); // Throw an error if either snapshot doesn't exist.
    // Returning 0 for both if either snapshot doesn't exist.
  }
}
