import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_fields_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

class SignIn extends StatefulWidget {
  final Function onSignInSuccess;

  const SignIn({super.key, required this.onSignInSuccess});

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
        addVerticalSpace(5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: TextStyle(color: Colors.grey[700]),
            ),
            TextButton(
              onPressed: () {
                widget.onSignInSuccess();
              },
              child: const Text("Sign Up"),
            ),
          ],
        ),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: BasicButton(
            text: "Sign In",
            onPressed: () async {
              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: _emailInput.text.trim(),
                  password: _passwordInput.text.trim(),
                );
                widget
                    .onSignInSuccess(); // Invoke the callback on successful sign in
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Failed to sign in: $e")));
              }
            },
          ),
        )),
      ],
    );
  }
}
