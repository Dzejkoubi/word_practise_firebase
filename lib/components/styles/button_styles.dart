import 'package:word_practise_firebase/components/styles/text_styles.dart';
import 'package:flutter/material.dart';

class BasicButton extends StatelessWidget {
  const BasicButton({super.key, this.onPressed, required this.text});

  final String text;
  final void Function()? onPressed;

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
        child: NormalText(
          text: text,
        ));
  }
}

class BasicElevatedButton extends StatelessWidget {
  const BasicElevatedButton({
    super.key,
    required this.text,
    this.onPressed,
  });

  final String text;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey[300] ?? Colors.grey; // Color when disabled
              }
              return Colors.grey[200] ?? Colors.grey; // Normal color
            },
          ),
          foregroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return Colors.grey[500]!; // Text color when disabled
              }
              return Colors.black; // Normal text color
            },
          ),
          shadowColor: MaterialStateProperty.all(
            Colors.grey.withOpacity(0.5),
          ),
          elevation: MaterialStateProperty.all(5),
          padding: MaterialStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          ),
        ),
        child: NormalText(
          text: text,
        ));
  }
}

class IconButtonStyle extends StatelessWidget {
  const IconButtonStyle({
    super.key,
    required this.onPressed,
    this.text,
    this.icon,
  }) : assert(text != null || icon != null,
            'You must provide either text or an icon.');

  final String? text;
  final void Function() onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon));
    }
    if (text != null) {
      children.add(Text(text!));
    }

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
      child: Row(
        mainAxisSize: MainAxisSize
            .min, // To keep the Row's size just as big as its children
        children: children,
      ),
    );
  }
}

class ImportantButton extends StatelessWidget {
  const ImportantButton(
      {super.key, this.onPressed, required this.text, this.icon});

  final String text;
  final void Function()? onPressed;
  final IconData? icon;

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
          const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon),
          if (icon != null) const SizedBox(width: 10),
          Text(text.toUpperCase(),
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              )),
        ],
      ),
    );
  }
}
