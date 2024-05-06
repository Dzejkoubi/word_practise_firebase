import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  final emailText = "null";
  final nicknameText = "null";
  final passwordText = "null";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NormalText(text: "Logged In"),
        addVerticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const NormalText(text: "Email: "),
            ImportantText(text: emailText),
          ],
        ),
        addVerticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const NormalText(text: "Nick Name: "),
            ImportantText(text: nicknameText),
          ],
        ),
        addVerticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const NormalText(text: "Password: "),
            ImportantText(text: passwordText),
          ],
        ),
        addVerticalSpace(20),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: BasicButton(
            text: "Log Out",
            onPressed: () {},
          ),
        )),
      ],
    );
  }
}
