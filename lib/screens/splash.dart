import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lottie/lottie.dart';
import 'package:manager/common/constants.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool isInternetConnected = true;

  bool showMessage = false;

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetConnected = false;
      });
      // Display message after a delay
      Timer(const Duration(seconds: 5), () {
        setState(() {
          showMessage = true;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    if (isInternetConnected) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted && isInternetConnected) {
          Navigator.pushNamed(context, Constants.signInRoute);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: isInternetConnected
          ? Scaffold(
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // SpinKitDoubleBounce(
                  //     size: MediaQuery.of(context).size.width * 0.2,
                  //     itemBuilder: (BuildContext context, int index) {
                  //       return Image.asset(Constants.splashScreenImage,
                  //           width: 250);
                  //     }),
                  Lottie.asset(Constants.appLogo,
                      width: MediaQuery.of(context).size.width),
                  const SizedBox(height: 20),
                  const Center(
                    child: Text(Constants.splashScreenText,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            )
          : !isInternetConnected && !showMessage
              ? Scaffold(
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(Constants.splashCheckingInternet,
                          width: MediaQuery.of(context).size.width),
                      const SizedBox(height: 10),
                      const Text(
                        Constants.checkingInternet,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                )
              : !isInternetConnected && showMessage
                  ? Scaffold(
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Center(
                            child: Text(
                              Constants.noInternet,
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey,
                                  decoration: TextDecoration.none),
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(),
    );
  }
}
