import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/generalStyles.dart';
import 'package:word_practise_firebase/components/styles/textStyles.dart';

class BasicTextField extends StatefulWidget {
  const BasicTextField({super.key, this.controller, this.hintText});

  final TextEditingController? controller;
  final String? hintText;

  @override
  State<BasicTextField> createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: AppShadows.customBoxShadow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.5)),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          suffix: IconButton(
            icon: const Icon(Icons.clear),
            color: Colors.black,
            onPressed: () {
              widget.controller?.clear();
            },
          ),
        ),
      ),
    );
  }
}
