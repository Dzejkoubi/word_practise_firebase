import 'package:flutter/material.dart';
import 'package:word_practise_firebase/main.dart';
import 'package:word_practise_firebase/pages/screens/wordsDatabase.dart';

class navBar extends StatefulWidget {
  const navBar({super.key});

  @override
  State<navBar> createState() => _navBarState();
}

List<IconData> _icons = [
  Icons.gamepad,
  Icons.list,
  Icons.account_box,
];

List<String> _titles = [
  "Game",
  "Your Words",
  "Profile",
];

class _navBarState extends State<navBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _icons
            .asMap()
            .map((i, e) => MapEntry(
                  i,
                  BottomNavigationBarItem(
                    icon: Icon(e),
                    label: _titles[i],
                  ),
                ))
            .values
            .toList(),
        selectedItemColor: Colors.indigo[700],
      ),
    );
  }
}
