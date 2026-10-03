import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';

class textformfeild_username extends StatelessWidget {
  const textformfeild_username(
      {super.key,
      required this.usernameController,
      required this.validationusername});

  final usernameController;
  final validationusername;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textDirection: TextDirection.ltr, // Aligns label text to the right
      controller: usernameController,
      decoration: InputDecoration(
          labelText: 'username',
          prefixIcon: const Icon(
            Icons.person,
            color: AppColors.color_textformfeild,
          ), // Arabic label text
          labelStyle: const TextStyle(color: Colors.teal), // Custom label color
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0), // Rounded border
            borderSide: const BorderSide(
                color: AppColors.color_textformfeild), // Border color
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(7.0), // Rounded border
            borderSide: const BorderSide(color: AppColors.text_gray), // Border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0), // Rounded border
            borderSide: const BorderSide(color: AppColors.text_gray), // Border
          )),
      validator: validationusername,
    );
  }
}
