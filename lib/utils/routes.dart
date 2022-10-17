import 'package:flutter/cupertino.dart';
import 'package:login_app_firebase_miner1/screens/login_screen.dart';
import 'package:login_app_firebase_miner1/screens/sign_up.dart';
import 'package:login_app_firebase_miner1/splash_screen.dart';


import '../screens/home_screen/page/home_screen.dart';
import 'appRoutes.dart';

Map<String, Widget Function(BuildContext)> routes = {
  AppRoutes().homePage: (context) => HomePage(),
  AppRoutes().signIn: (context) => SignIn(),
  AppRoutes().signUp: (context) => SignUp(),
  AppRoutes().splashScreen: (context) => IntroScreen(),

};
