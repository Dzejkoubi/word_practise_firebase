import 'package:firebase_database/firebase_database.dart';

final wordsRef = FirebaseDatabase.instance.ref().child("words");

// Fetch all words as a list
Future<List<dynamic>> getWords() async {
  try {
    final snapshot = await wordsRef.get();
    if (snapshot.exists && snapshot.value is List) {
      return List<dynamic>.from(snapshot.value as List);
    } else {
      print("No words available");
      return [];
    }
  } catch (e) {
    print("Error fetching words: $e");
    return [];
  }
}

Future<List<dynamic>> words = getWords();

Future<int> getWordsCount() async {
  int wordCount = await getWords().then((words) => words.length);
  return wordCount;
}

Future<int> wordsCount = getWordsCount();
