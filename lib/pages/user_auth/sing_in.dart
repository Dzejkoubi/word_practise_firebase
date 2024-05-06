import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NormalText(text: "Sign In"),
        addVerticalSpace(20),
        BasicTextField(
          controller: _emailInput,
          hintText: "E-mail",
        ),
        addVerticalSpace(10),
        PasswordTextField(
          controller: _passwordInput,
          hintText: "Password",
        ),
        addVerticalSpace(20),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: BasicButton(
            text: "Sign In",
            onPressed: () {
              print("Email: ${_emailInput.text}");
              print("Password: ${_passwordInput.text}");
            },
          ),
        )),
      ],
    );
  }
}
