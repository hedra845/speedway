import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/presentaion/home/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  Widget spinkit = const SpinKitRotatingCircle(
    color: AppColors.primaryColor,
    size: 50.0,
  );
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () async {
      // ignore: unnecessary_null_comparison
      const FlutterSecureStorage secureStorage = FlutterSecureStorage();

      // Read the token with the key 'token'
      String? token = await secureStorage.read(key: 'token');
Navigator.pushReplacement(context,
    MaterialPageRoute(builder: (context) =>  Home_page()));
        });
  }

  Future getvalidationdata() async {
    final SharedPreferences logined = await SharedPreferences.getInstance();
    // ignore: unused_local_variable
    var obtainedstateLogin = logined.getBool('logined') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppColors.white,
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/images/app_logo.png",
                width: 180,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              LoadingAnimationWidget.discreteCircle(
                color: AppColors.primaryColor,
                secondRingColor: AppColors.red,
                thirdRingColor: AppColors.yellow,
                size: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
