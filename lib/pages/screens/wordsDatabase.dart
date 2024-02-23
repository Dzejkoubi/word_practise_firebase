import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class wordsDatabase {
  final CollectionReference wordsCollection =
      FirebaseFirestore.instance.collection('words');
}
