import 'package:flutter/material.dart';
import 'package:manager/screens/email_auth.dart';
import 'package:manager/screens/home.dart';
import 'package:manager/screens/sign_up_screen.dart';
import 'package:manager/screens/splash.dart';

import 'common/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Constants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Splash(),
      routes: {
        Constants.signUpRoute: (context) => const SignUp(),
        Constants.emailAuthRoute: (context) => const EmailAuth(),
        Constants.homeRoute: (context) => const Home(),
      },
    );
  }
}
