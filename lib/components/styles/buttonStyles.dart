import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/textStyles.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({super.key, required this.onPressed, required this.text});

  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.grey[200],
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.black,
          ),
          shadowColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
        ),
        autofocus: true,
        child: NormalText(
          text: text,
        ));
  }
}

class IconButtonStyle extends StatelessWidget {
  const IconButtonStyle(
      {super.key,
      required this.onPressed,
      required this.text,
      required this.icon});

  final String text;
  final void Function() onPressed;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            Colors.grey[200],
          ),
          foregroundColor: MaterialStateProperty.all(
            Colors.black,
          ),
          shadowColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
        ),
        autofocus: true,
        child: NormalText(
          text: text,
        ));
    ;
  }
}
