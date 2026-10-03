import 'package:flutter/material.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/widgets/dividers.dart';
import 'package:sender/presentaion/splach/splachscreen.dart';
import 'package:svg_flutter/svg.dart';
import '../../widgets/re_enter_button_error_screen.dart';

class Error_screen extends StatefulWidget {
  const Error_screen({super.key});

  @override
  State<Error_screen> createState() => _Error_screenState();
}

class _Error_screenState extends State<Error_screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/images/images/error_network.svg',
                  height: 200,
                  width: double.infinity,
                ),
                const Dividers(
                  height: 20,
                  color: AppColors.background,
                ),
                const Text(
                  'لا يمكنك الدخول',
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cairo'),
                ),
                const Text(
                  'هناك مشكلة في اتصالك بالانترنت',
                  style: TextStyle(
                      color: AppColors.text_gray,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                      fontFamily: 'cairo'),
                ),
                const Dividers(
                  height: 20,
                  color: AppColors.background,
                ),
                re_enter_button(
                  re_enter_button_onPressed: () async {
                      // Network is available, navigate to the desired screen
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SplashScreen()));
                      // Network is not available, display an error message
                    
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
