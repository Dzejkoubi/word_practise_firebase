import 'package:firebase_auth/firebase_auth.dart';
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

//Checks if the form is valid and displays a snackbar if it is not
  bool validateForm() {
    String nickname = _nickNameInput.text.trim();
    String email = _emailInput.text.trim();
    String password = _passwordInput.text.trim();
    String confirmPassword = _confirmPasswordInput.text.trim();

    if (nickname.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please fill all fields")));
      return false;
    }
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter a valid email")));
      return false;
    }
    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Password must be at least 8 characters long")));
      return false;
    }
    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")));
      return false;
    }
    return true;
  }

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
            onPressed: () async {
              if (validateForm()) {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailInput.text.trim(),
                    password: _passwordInput.text.trim(),
                  );
                  setState(() {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Sign up successful")));
                  });
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to sign up: $e")));
                }
              }
            },
          ),
        )),
      ],
    );
  }
}
