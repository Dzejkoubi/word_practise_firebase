import 'package:flutter/material.dart';
import 'package:word_practise_firebase/main.dart';
import 'package:word_practise_firebase/pages/screens/wordsDatabase.dart';
import 'package:flutter/material.dart';
// Bottom Navigation Bar
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';

// Pages
import 'package:word_practise_firebase/pages/screens/userCentre.dart';
import 'package:word_practise_firebase/pages/screens/wordLists.dart';
import 'package:word_practise_firebase/main.dart';

class motionBar extends StatefulWidget {
  const motionBar({super.key});

  @override
  State<motionBar> createState() => _motionBarState();
}

class _motionBarState extends State<motionBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GNav(
        rippleColor: Colors.grey[300]!,
        hoverColor: Colors.grey[100]!,
        gap: 8,
        activeColor: Colors.black,
        iconSize: 24,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        duration: Duration(milliseconds: 400),
        tabBackgroundColor: Colors.grey[100]!,
        color: Colors.black,
        tabs: [
          GButton(
            icon: LineIcons.home,
            text: 'Home',
          ),
          GButton(
            icon: LineIcons.heart,
            text: 'Likes',
          ),
          GButton(
            icon: LineIcons.search,
            text: 'Search',
          ),
          GButton(
            icon: LineIcons.user,
            text: 'Profile',
          ),
        ],
        selectedIndex: _selectedIndex,
        onTabChange: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
