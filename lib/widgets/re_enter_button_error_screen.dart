import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';

class re_enter_button extends StatelessWidget {
  const re_enter_button({super.key, required this.re_enter_button_onPressed});

  final Function? re_enter_button_onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Set the border radius
          ),
          overlayColor: AppColors.background,
          backgroundColor: AppColors.primaryColor, // Set the background color
        ),
        onPressed: () async {
          re_enter_button_onPressed!();
        },
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              color: AppColors.white,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'إعادة الدخول',
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'cairo',
                  fontWeight: FontWeight.bold,
                  color: AppColors.white),
            ),
          ],
        ),
      ),
    );
  }
}
