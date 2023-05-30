import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  // route for navigation to this screen
  static const String routeName = Constants.signUpRoute;

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isGoogleHover = false;

  bool isFacebookHover = false;

  bool isEmailHover = false;

  bool isSkipTap = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(Constants.signUpScreenTitle,
              style: TextStyle(fontSize: 20)),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
                elevation: 5,
                borderOnForeground: true,
                color: Colors.grey[200],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: MediaQuery.of(context).size.width > 600
                    ? const EdgeInsets.symmetric(horizontal: 100)
                    : const EdgeInsets.symmetric(horizontal: 17),
                child: Padding(
                  padding: MediaQuery.of(context).size.width > 600
                      ? const EdgeInsets.all(50)
                      : const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Google Sign Up Button
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, Constants.homeRoute);
                        },
                        onTapDown: (details) {
                          setState(() {
                            isGoogleHover = true;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            isGoogleHover = false;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            isGoogleHover = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: isGoogleHover
                              ? Matrix4.translationValues(0, -5, 0)
                              : Matrix4.translationValues(0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isGoogleHover
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Card(
                            // elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.red,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.google,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    Constants.signUpScreenGoogleButton,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Facebook Sign Up Button
                      GestureDetector(
                        onTap: () {
                          // Navigator.pushNamed(context, Constants.homeRoute);
                        },
                        onTapDown: (details) {
                          setState(() {
                            isFacebookHover = true;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            isFacebookHover = false;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            isFacebookHover = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: isFacebookHover
                              ? Matrix4.translationValues(0, -5, 0)
                              : Matrix4.translationValues(0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isFacebookHover
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.blue,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.facebook,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    Constants.signUpScreenFacebookButton,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Sign up with email button
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, Constants.emailAuthRoute);
                        },
                        onTapDown: (details) {
                          setState(() {
                            isEmailHover = true;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            isEmailHover = false;
                          });
                        },
                        onTapUp: (details) {
                          setState(() {
                            isEmailHover = false;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          transform: isEmailHover
                              ? Matrix4.translationValues(0, -5, 0)
                              : Matrix4.translationValues(0, 0, 0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: isEmailHover
                                ? [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 10,
                                      spreadRadius: 2,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Colors.grey,
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.envelope,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 20),
                                  Text(
                                    Constants.signUpWithEmailButton,
                                    style: TextStyle(
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05,
                                        color: Colors.white),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 20),
          // Already have an account button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(Constants.signUpScreenAlreadyHaveAccount,
                  style: TextStyle(fontSize: 16)),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Constants.signInRoute);
                },
                child: const Text(Constants.loginButton,
                    style: TextStyle(fontSize: 18, color: Colors.blue)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Skip this step button
          // GestureDetector(
          //   onTap: () {
          //     setState(() {
          //       isSkipTap = true;
          //     });
          //     Navigator.pushNamed(context, Constants.homeRoute);
          //   },
          //   child: Text(
          //     Constants.signUpScreenSkipButton,
          //     style: TextStyle(
          //         fontSize: MediaQuery.of(context).size.width * 0.05,
          //         color: isSkipTap ? Colors.blue : Colors.black),
          //     textAlign: TextAlign.center,
          //     overflow: TextOverflow.ellipsis,
          //   ),
          // )
        ],
      ),
    ));
  }
}
