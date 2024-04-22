import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helperWidgets.dart';
import 'package:word_practise_firebase/components/styles/buttonStyles.dart';
import 'package:word_practise_firebase/components/styles/textFieldStyles.dart';
import 'package:word_practise_firebase/components/helperWidgets.dart';

class UserCentre extends StatefulWidget {
  const UserCentre({super.key});

  @override
  State<UserCentre> createState() => _UserCentreState();
}

class _UserCentreState extends State<UserCentre> {
  //Text controllers
  final _firstNameInput = TextEditingController();
  final _secondNameInput = TextEditingController();
  final _nickNameInput = TextEditingController();
  final _emailInput = TextEditingController();
  final _passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            BasicTextField(
              hintText: "First Name",
              controller: _firstNameInput,
            ),
            addVerticalSpace(10),
            BasicTextField(
              hintText: "Second Name",
              controller: _secondNameInput,
            ),
            addVerticalSpace(10),
            BasicTextField(
              hintText: "Nick Name",
              controller: _nickNameInput,
            ),
            addVerticalSpace(10),
            BasicTextField(
              hintText: "Email",
              controller: _emailInput,
            ),
            addVerticalSpace(10),
            BasicTextField(
              hintText: "Password",
              controller: _passwordInput,
            ),
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              child: BasicButton(
                text: "Submit",
                onPressed: () {
                  print("First name: ${_firstNameInput.text}");
                  print("Second name: ${_secondNameInput.text}");
                  print("Nick name: ${_nickNameInput.text}");
                  print("Email: ${_emailInput.text}");
                  print("Password: ${_passwordInput.text}");
                },
              ),
            )),
          ],
        ),
      ),
    );
  }
}
