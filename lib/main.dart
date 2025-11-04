import 'package:flutter/material.dart';
import 'package:hiwaygo/features/auth/page_forgot_password.dart';
import 'package:hiwaygo/features/auth/page_sign_in.dart';
import 'package:hiwaygo/features/auth/page_sign_up.dart';
import 'package:hiwaygo/features/page_home.dart';
import 'package:hiwaygo/features/tracking/page_bus_tracking_map.dart';
import 'package:hiwaygo/routes.dart';

void main() async{
  runApp(GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const PageSignIn(),

          Routes.signInPage: (context) => const PageSignIn(),
          Routes.signUpPage: (context) => const PageSignUp(),
          Routes.forgotPasswordPage: (context) => const PageForgotPassword(),
          Routes.busTrackingMapPage: (context) => const PageBusTrackingMap(),
          Routes.homePage: (context) => PageHome()
        },
      ),
    ),
  ));
}
