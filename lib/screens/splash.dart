import 'package:flutter/material.dart';
import 'package:manager/common/constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, Constants.signUpRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Constants.splashScreenImage, width: 200, height: 200),
            const SizedBox(height: 20),
            const Text(Constants.splashScreenText,
                style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    ));
  }
}
