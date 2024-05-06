import 'package:flutter/material.dart';
import 'package:word_practise_firebase/components/styles/general_styles.dart';

class BasicTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;

  const BasicTextField({
    Key? key,
    this.controller,
    required this.hintText,
    this.obscureText = false,
  }) : super(key: key);

  @override
  _BasicTextFieldState createState() => _BasicTextFieldState();
}

class _BasicTextFieldState extends State<BasicTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 350,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.grey[200],
          boxShadow: AppShadows.customBoxShadow,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.black, width: 1.5)),
      child: TextField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: widget.hintText,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggleVisibility,
                )
              : null,
        ),
      ),
    );
  }
}

class PasswordTextField extends BasicTextField {
  PasswordTextField({
    Key? key,
    TextEditingController? controller,
    String hintText = 'Password',
  }) : super(
          key: key,
          controller: controller,
          hintText: hintText,
          obscureText: true, // Enable the obscureText feature for passwords
        );
}
