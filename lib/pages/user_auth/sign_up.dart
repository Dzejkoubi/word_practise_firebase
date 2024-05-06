import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //Text controllers
  final _nickNameInput = TextEditingController();
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();
  final _confirmPasswordInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const NormalText(text: "Sign Up"),
        addVerticalSpace(20),
        BasicTextField(
          controller: _nickNameInput,
          hintText: "Nick Name",
        ),
        addVerticalSpace(10),
        BasicTextField(
          controller: _emailInput,
          hintText: "E-mail",
        ),
        addVerticalSpace(10),
        PasswordTextField(
          controller: _passwordInput,
          hintText: "Password",
        ),
        addVerticalSpace(10),
        PasswordTextField(
          controller: _confirmPasswordInput,
          hintText: "Confirm Password",
        ),
        addVerticalSpace(20),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: BasicButton(
            text: "Sign Up",
            onPressed: () {
              print("Nick name: ${_nickNameInput.text}");
              print("Email: ${_emailInput.text}");
              print("Password: ${_passwordInput.text}");
              print("Confirm Password: ${_confirmPasswordInput.text}");
            },
          ),
        )),
      ],
    );
  }
}
