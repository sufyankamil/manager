import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:manager/screens/email_auth.dart';
import 'package:manager/screens/home.dart';
import 'package:manager/screens/login_screen.dart';
import 'package:manager/screens/phone_auth.dart';
import 'package:manager/screens/sign_up_screen.dart';
import 'package:manager/screens/splash.dart';

import 'common/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final storage = const FlutterSecureStorage();

  Future<bool> isLoggedIn() async {
    final token = await storage.read(key: Constants.userTokenKey);
    if (token == null) {
      return false;
    }
    return true;
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: Text(Constants.errorLoading,
                      style: TextStyle(fontSize: 20)),
                ),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: Constants.appName,
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: FutureBuilder(
                future: isLoggedIn(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data == false) {
                      return const Splash();
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Colors.white,
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      return const Home();
                    }
                  }
                  return const Splash();
                },
              ),
              routes: {
                Constants.signUpRoute: (context) => const SignUp(),
                Constants.signInRoute: (context) => const Login(),
                Constants.emailAuthRoute: (context) => const EmailAuth(),
                Constants.phoneAuthRoute: (context) => const PhoneAuth(),
                Constants.homeRoute: (context) => const Home(),
              },
            );
          }

          // Otherwise, show something message or circularbar while waiting for initialization to complete
          return MaterialApp(
            title: Constants.appName,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Center(
                    child:
                        Text(Constants.loading, style: TextStyle(fontSize: 20)),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
        });
  }
}
