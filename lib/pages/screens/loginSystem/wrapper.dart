import 'package:flutter/material.dart';
import 'package:word_practise_firebase/pages/screens/loginSystem/signIn.dart';
import 'package:word_practise_firebase/pages/screens/game.dart';
import 'package:word_practise_firebase/pages/screens/loginSystem/authentication.dart';

class wrapper extends StatelessWidget {
  const wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: signIn(),
    );
  }
}
