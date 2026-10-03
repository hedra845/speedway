import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';

Widget TexxtFormFeild(
  String text,
  TextEditingController? controller,
  String? Function(String?)? validator,
  bool readOnly,
  String? initialValue,
  TextInputType type,
  int max,
  Color iconColor,
  Icon icon,
) {
  return TextFormField(
    keyboardType: type,
    controller: controller,
    validator: validator,
    readOnly: readOnly,
    initialValue: initialValue,
    maxLines: max,
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    style: const TextStyle(
      fontFamily: 'cairo',
      fontSize: 14,
      color: Color(0xFF1E293B),
    ),
    decoration: InputDecoration(
      prefixIcon: icon,
      prefixIconColor: iconColor.withValues(alpha: 0.7),
      fillColor: const Color(0xFFF8FAFC),
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 13.0, horizontal: 14.0),
      hintText: text,
      hintTextDirection: TextDirection.rtl,
      hintStyle: const TextStyle(
        fontFamily: 'cairo',
        fontSize: 13.0,
        color: Color(0xFF94A3B8),
      ),
      errorStyle: const TextStyle(
        fontFamily: 'cairo',
        fontSize: 11.0,
        color: AppColors.red,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.red, width: 1.2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: AppColors.red, width: 1.6),
      ),
    ),
  );
}
