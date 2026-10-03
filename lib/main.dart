import 'package:sender/conponantes/constantes/colores.dart';
import 'package:sender/presentaion/add%20order/form_add_order.dart';
import 'package:sender/presentaion/auth/login_screen.dart';
import 'package:sender/presentaion/error/error_screen.dart';
import 'package:sender/presentaion/help_center/help_center_page.dart';
import 'package:sender/presentaion/home/home_page.dart';
import 'package:sender/presentaion/orders/orders.dart';
import 'package:sender/presentaion/personal_page_data.dart/personal_data.dart';
import 'package:sender/presentaion/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:sender/presentaion/pusher/page_home_pusher.dart';
import 'package:sender/presentaion/request_pickup/request_pickup.dart';
import 'package:sender/presentaion/scanner/scanar_main_orders.dart';
import 'package:sender/presentaion/settings/settings.dart';
import 'package:sender/presentaion/splach/splachscreen.dart';

void main() {
   FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
  };
  runApp(const sender());
}

class sender extends StatelessWidget {
  const sender({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: const Locale('ar'),
      supportedLocales: const [
        Locale('ar'),
        Locale('en'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: 'cairo',
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/home_screen': (context) =>  const Home_page(),
        '/login_screen': (context) =>  const LoginScreen(),
        '/error_screen': (context) =>  const Error_screen(),
        '/Orders_Page': (context) =>  const Orders(),
        '/notifications_page': (context) =>  const PageHomePusher(),
        '/profile_page': (context) => const ProfileScreen(),
        '/help_center': (context) => const HelpCenter(),
        '/add_order': (context) => const FormAddOrder(),
        '/picked_up': (context) => const Form_request_pickup(),
        '/personal_data': (context) => const PersonalData(),
        '/Settings': (context) => const Settings(),
        '/BarcodeScannerScreen': (context) =>  const BarcodeScannerScreen(),
        // '/picked_up': (context)=> PickedUpOrders(),
      },
      home:  SplashScreen(),
    );
  }
}
