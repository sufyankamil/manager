import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../common/constants.dart';

class EmailAuth extends StatefulWidget {
  const EmailAuth({super.key});

  // route for navigation to this screen
  static const String route = Constants.emailAuthRoute;

  @override
  State<EmailAuth> createState() => _EmailAuthState();
}

class _EmailAuthState extends State<EmailAuth> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  bool _isObscure = true;

  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (!isChecked) {
        _showAlertDialog(context);
      } else {}
      // Perform account creation logic here
      String email = _emailController.text;
      String password = _passwordController.text;
      // Call an API or perform any other necessary actions
      print('Creating account with email: $email and password: $password');
    }
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.7;

    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      const Icon(
                        FontAwesomeIcons.envelope,
                      ),
                      const SizedBox(height: 20),
                      const Text(Constants.signUpWithEmailButton,
                          style: TextStyle(fontSize: 20)),
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
                      // terms and conditions
                      Row(
                        children: <Widget>[
                          Checkbox(
                            value: isChecked,
                            onChanged: (value) {
                              setState(() {
                                isChecked = value!;
                              });
                            },
                          ),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              // termsAndContions(context);
                            },
                            child: SizedBox(
                              width: c_width,
                              child: Text(
                                Constants.agreementContent,
                                maxLines: 5,
                                overflow: TextOverflow.visible,
                                style: isChecked
                                    ? Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.blue,
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(
                                          color: Colors.grey,
                                          fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width >
                                                  400
                                              ? 16
                                              : 14,
                                        ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Create Account'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ));
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
}
