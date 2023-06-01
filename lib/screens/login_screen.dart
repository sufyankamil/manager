import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';

import '../common/constants.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  // route for navigation to this screen
  static const String route = Constants.signInRoute;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final storage = const FlutterSecureStorage();

  bool _isObscure = true;

  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;

    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 50),
        height: MediaQuery.of(context).size.height,
        width: c_width,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(Constants.loginLogo,
                  width: MediaQuery.of(context).size.width),
              const Text(Constants.loginScreenTitle,
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                      icon: Icon(
                        _isObscure
                            ? FontAwesomeIcons.solidEyeSlash
                            : FontAwesomeIcons.eye,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text(Constants.loginButton),
              ),
              const SizedBox(height: 20),
              // Dont have an account? Sign up
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    Constants.dontHaveAccount,
                    style: TextStyle(fontSize: 16),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Constants.signUpRoute);
                    },
                    child: const Text(Constants.signUpButton,
                        style: TextStyle(color: Colors.blue, fontSize: 18)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        // Perform account creation logic here
        String email = _emailController.text;
        String password = _passwordController.text;
        // Call an API or perform any other necessary actions
        print('Creating account with email: $email and password: $password');
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        await storage.write(
            key: Constants.userTokenKey, value: userCredential.user!.uid);
        print(userCredential);
        if (userCredential != null) {
          setState(() {
            _emailController.clear();
            _passwordController.clear();
          });
          Navigator.of(context).pushNamed(Constants.homeRoute);
        } else {
          print('User not created');
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          _showUserNotFoundDialog(context);
        } else if (e.code == 'email-already-in-use') {
          _showAccountExistsDialog(context);
        }
      } catch (e) {
        print(e);
      }
    }
  }

  // when user not found
  void _showUserNotFoundDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.userNotFound),
          content: const Text(Constants.userNotFoundMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(Constants.ok)),
          ],
        );
      },
    );
  }

  // dialog to show terms and conditions of the app
  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.agreementTitle),
          content: const Text(Constants.agreeTerms),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(Constants.ok)),
          ],
        );
      },
    );
  }

  // function when account already exists
  void _showAccountExistsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Constants.accountExists),
          content: const Text(Constants.accountExistsMessage),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(Constants.ok)),
          ],
        );
      },
    );
  }
}
