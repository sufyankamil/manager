import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
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
      if(mounted){
        Navigator.pushNamed(context, Constants.signInRoute);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SpinKitDoubleBounce(
              // color: Colors.blue,
              size: MediaQuery.of(context).size.width * 0.2,
              itemBuilder: (BuildContext context, int index) {
                return Image.asset(Constants.splashScreenImage, width: 250);
              }),
          const SizedBox(height: 20),
          const Text(Constants.splashScreenText,
              style: TextStyle(fontSize: 20)),
          const SizedBox(height: 30),
        ],
      ),
    ));
  }
}
