import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';

import '../common/constants.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  // route to phone auth screen
  static const String routeName = Constants.phoneAuthRoute;

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth>
    with SingleTickerProviderStateMixin {
  final TextEditingController phoneController = TextEditingController();

  bool isOtpSent = false;

  bool otpVerified = false;

  var codes = "";

  final List<TextEditingController> _otpControllers =
      List.generate(6, (_) => TextEditingController());

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 1500), vsync: this);
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    _controller.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Country countryCode = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    example: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(255, 108, 9, 112)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromARGB(255, 70, 14, 209)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromARGB(255, 23, 186, 36),
      ),
    );

    // selection of the text field is set to the end of the text
    phoneController.selection = TextSelection.fromPosition(
      TextPosition(offset: phoneController.text.length),
    );

    // Function to send otp from firebase
    void sendOtp() async {
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+${countryCode.phoneCode}${phoneController.text}',
        verificationCompleted: (PhoneAuthCredential credential) async {
          // await FirebaseAuth.instance.signInWithCredential(credential);
          // setState(() {
          //   otpVerified = true;
          // });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          setState(() {
            isOtpSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    }

    // verify otp function
    void verifyOtp() async {
      final code = _otpControllers.map((e) => e.text).join();
      try {
        final credential = PhoneAuthProvider.credential(
            verificationId: FirebaseAuth.instance.currentUser!.uid,
            smsCode: codes);
        await FirebaseAuth.instance.signInWithCredential(credential);
        Navigator.of(context).pushNamedAndRemoveUntil(
            Constants.homeRoute, (Route<dynamic> route) => false);
        setState(() {
          otpVerified = true;
        });
      } catch (e) {
        print('wrong otp');
      }
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image.asset(
                    //   Constants.otpImage,
                    //   height: 200,
                    //   width: 200,
                    // ),
                    isOtpSent == false && otpVerified == false
                        ? Lottie.asset(
                            Constants.phoneImage,
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.4,
                          )
                        : isOtpSent == true && otpVerified == false
                            ? Lottie.asset(
                                Constants.phoneVerify,
                                width: MediaQuery.of(context).size.width,
                              )
                            : Lottie.asset(
                                Constants.verified,
                                width: MediaQuery.of(context).size.width,
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      Constants.phoneAuthScreenTitle,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      Constants.phoneMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isOtpSent == false
                        ? TextFormField(
                            controller: phoneController,
                            cursorColor: Colors.purple,
                            onChanged: (value) {
                              setState(() {
                                phoneController.text = value;
                              });
                            },
                            decoration: InputDecoration(
                              hintText: Constants.phoneAuthScreenHint,
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              prefixIcon: Container(
                                  padding: const EdgeInsets.all(8),
                                  child: InkWell(
                                    onTap: () {
                                      showCountryPicker(
                                        context: context,
                                        countryListTheme:
                                            const CountryListThemeData(
                                          bottomSheetHeight: 550,
                                          backgroundColor: Colors.white,
                                        ),
                                        showPhoneCode: true,
                                        onSelect: (Country country) {
                                          setState(() {
                                            countryCode = country;
                                          });
                                        },
                                      );
                                    },
                                    child: Text(
                                      "${countryCode.flagEmoji} +${countryCode.phoneCode}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )),
                            ),
                          )
                        // : Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        //     children: [
                        //       for (var i = 0; i < 6; i++)
                        //         SizedBox(
                        //           width: 40,
                        //           child: TextFormField(
                        //             controller: _otpControllers[i],
                        //             keyboardType: TextInputType.number,
                        //             textAlign: TextAlign.center,
                        //             decoration: const InputDecoration(
                        //               enabledBorder: OutlineInputBorder(
                        //                 borderSide:
                        //                     BorderSide(color: Colors.grey),
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(10)),
                        //               ),
                        //               focusedBorder: OutlineInputBorder(
                        //                 borderSide:
                        //                     BorderSide(color: Colors.purple),
                        //                 borderRadius: BorderRadius.all(
                        //                     Radius.circular(10)),
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //     ],
                        //   ),
                        : Pinput(
                            length: 6,
                            defaultPinTheme: defaultPinTheme,
                            focusedPinTheme: focusedPinTheme,
                            submittedPinTheme: submittedPinTheme,
                            // validator: (s) {

                            // },
                            pinputAutovalidateMode:
                                PinputAutovalidateMode.onSubmit,
                            onChanged: (value) {
                              codes = value;
                            },
                            showCursor: true,
                          ),
                    const SizedBox(height: 20),
                    phoneController.text.length >= 9 && isOtpSent == false
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                sendOtp();
                                // setState(() {
                                //   isOtpSent = true;
                                // });
                              },
                              child: const Text(Constants.sendOtp),
                            ),
                          )
                        // disable the button if the phone number is not valid
                        : const SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: null,
                              child: Text(Constants.sendOtp),
                            ),
                          ),
                    isOtpSent == true
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                verifyOtp();
                                // setState(() {
                                //   isOtpSent = true;
                                // });
                                // String otp = _otpControllers
                                //     .map((controller) => controller.text)
                                //     .join();
                                // if (otp.length == 6) {
                                //   // verify otp
                                //   // print('OTP Verified');
                                //   // setState(() {
                                //   //   otpVerified = true;
                                //   // });
                                // } else {
                                //   // Show an error message if the entered OTP is not valid
                                //   showDialog(
                                //     context: context,
                                //     builder: (BuildContext context) {
                                //       return AlertDialog(
                                //         title: const Text(Constants.error),
                                //         content: const Text(Constants.validOtp),
                                //         actions: [
                                //           TextButton(
                                //             child: const Text('OK'),
                                //             onPressed: () {
                                //               Navigator.of(context).pop();
                                //             },
                                //           ),
                                //         ],
                                //       );
                                //     },
                                //   );
                                // }
                              },
                              child: const Text(Constants.verifyOtp),
                            ),
                          )
                        // disable the button if the phone number is not valid
                        : const SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: null,
                              child: Text(Constants.verifyOtp),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
