import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/helper_widgets.dart';
import 'package:word_practise_firebase/components/styles/button_styles.dart';
import 'package:word_practise_firebase/components/styles/text_styles.dart';

import 'package:firebase_auth/firebase_auth.dart';

class LoggedIn extends StatefulWidget {
  const LoggedIn({super.key});

  @override
  State<LoggedIn> createState() => _LoggedInState();
}

class _LoggedInState extends State<LoggedIn> {
  User? currentUser = FirebaseAuth.instance.currentUser;

  void updateEmail(String email) async {
    try {
      await currentUser!.updateEmail(email);
      FirebaseAuth.instance.currentUser!.reload();
      setState(() {}); // Refresh the UI with the new email
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to update email: $e"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void updateDisplayName(String displayName) async {
    try {
      await currentUser!.updateProfile(displayName: displayName);
      FirebaseAuth.instance.currentUser!.reload();
      setState(() {}); // Refresh the UI with the new display name
    } catch (e) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error"),
          content: Text("Failed to update display name: $e"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  void showEditDialog(String field, Function(String) updateFunction) {
    final _controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: "Enter new $field"),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              updateFunction(_controller.text.trim());
            },
            child: const Text("Update"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String emailText = currentUser?.email ?? "No email";
    String displayName = currentUser?.displayName ?? "No nickname";

    return Column(
      children: <Widget>[
        const NormalText(text: "Logged In"),
        addVerticalSpace(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const NormalText(text: "Email: "),
            ImportantText(text: emailText),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => showEditDialog("email", updateEmail),
            ),
          ],
        ),
        addVerticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const NormalText(text: "Nick Name: "),
            ImportantText(text: displayName),
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => showEditDialog("nickname", updateDisplayName),
            ),
          ],
        ),
        addVerticalSpace(20),
        Expanded(
            child: Container(
          alignment: Alignment.topCenter,
          child: BasicButton(
            text: "Log Out",
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context)
                  .pushReplacementNamed('/sign_in'); // Update this as needed
            },
          ),
        )),
      ],
    );
  }
}
