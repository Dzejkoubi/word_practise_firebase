import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/pages/user_auth/logged_in.dart';
import 'package:word_practise_firebase/pages/user_auth/sign_up.dart';
import 'package:word_practise_firebase/pages/user_auth/sing_in.dart';

class UserCentre extends StatefulWidget {
  const UserCentre({super.key});

  @override
  State<UserCentre> createState() => _UserCentreState();
}

class _UserCentreState extends State<UserCentre> {
  int currentPageIndex = 0; // Start with SignUp page
  final List<Widget> userCentrePages = <Widget>[
    const SignUp(),
    const SignIn(),
    const LoggedIn(),
  ];

  void changePage(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return userCentrePages[currentPageIndex];
  }
}
