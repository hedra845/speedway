import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';

class textformfeild_password extends StatefulWidget {
  const textformfeild_password({super.key, required this.passwordController});

  final passwordController;
  @override
  State<textformfeild_password> createState() => _textformfeild_passwordState();
}

class _textformfeild_passwordState extends State<textformfeild_password> {
  //password eye
  final textFieldFocusNode = FocusNode();
  bool _obscured = true;
  void _toggleObscured() {
    setState(() {
      _obscured = !_obscured;
      if (textFieldFocusNode.hasPrimaryFocus) {
        return; // If focus is on text field, dont unfocus
      }
      textFieldFocusNode.canRequestFocus =
          false; // Prevents focus if tap on eye
    });
  }

  bool visible = false;

  //password eye end

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscured,
      textDirection: TextDirection.ltr, // Aligns label text to the right
      controller: widget.passwordController,
      cursorColor: AppColors.primaryColor,
      decoration: InputDecoration(
          labelText: 'password',
          prefixIcon: const Icon(
            Icons.lock,
            color: AppColors.color_textformfeild,
          ),
          // Arabic label text
          suffixIcon: GestureDetector(
            onTap: _toggleObscured,
            child: Icon(
              _obscured
                  ? Icons.visibility_rounded
                  : Icons.visibility_off_rounded,
              size: 24,
              color: AppColors.text_gray,
            ),
          ),
          labelStyle: const TextStyle(color: Colors.teal), // Custom label color
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0), // Rounded border
              borderSide: const BorderSide(color: AppColors.text_gray)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded border
            borderSide: const BorderSide(color: AppColors.text_gray), // Border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded border
            borderSide: const BorderSide(color: AppColors.text_gray), // Border
          ) // Border color
          ),
      validator: (password) {
        if (password == null || password.isEmpty) {
          return 'Please enter password';
        }
        return null;
      },
    );
  }
}
