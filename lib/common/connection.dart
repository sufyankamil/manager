import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:manager/common/constants.dart';

class Connection extends StatefulWidget {
  const Connection({super.key});

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  bool isInternetConnected = true;

  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    checkInternetConnection();
    if (isInternetConnected) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          Navigator.pushNamed(context, Constants.signInRoute);
        }
      });
    }
  }

  Future<void> checkInternetConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isInternetConnected = false;
      });
      // Display message after a delay
      Timer(const Duration(seconds: 3), () {
        setState(() {
          showMessage = true;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isInternetConnected)
              const Text(
                Constants.checkingInternet,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              ),
            const SizedBox(height: 25),
            const CircularProgressIndicator(color: Colors.grey),

            // 2
            if (!isInternetConnected && !showMessage)
              const Text(
                Constants.checkingInternet,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              ),

            // 3
            if (!isInternetConnected && showMessage)
              const Text(
                Constants.noInternet,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    decoration: TextDecoration.none),
              ),
          ],
        ),
        //   child: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: const [
        //     Text(
        //       Constants.checkingInternet,
        //       style: TextStyle(
        //           fontSize: 30,
        //           fontWeight: FontWeight.bold,
        //           color: Colors.grey,
        //           decoration: TextDecoration.none),
        //     ),
        //     SizedBox(height: 25),
        //     CircularProgressIndicator(color: Colors.grey)
        //   ],
        // ),
      ),
    );
  }
}
