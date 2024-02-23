class WordEntry {
  final List<String> czech;
  final List<String> english;
  final List<String>? hint;

  WordEntry({required this.czech, required this.english, this.hint});

  factory WordEntry.fromJson(Map<String, dynamic> json) {
    return WordEntry(
      czech: List<String>.from(json['czech']),
      english: List<String>.from(json['english']),
      hint: json['hint'] == null ? null : List<String>.from(json['hint']),
    );
  }
}

class WordList {
  final List<WordEntry> words;

  WordList({required this.words});

  factory WordList.fromJson(Map<String, dynamic> json) {
    var list = json['words'] as List;
    List<WordEntry> wordsList = list.map((e) => WordEntry.fromJson(e)).toList();
    return WordList(words: wordsList);
  }
}
