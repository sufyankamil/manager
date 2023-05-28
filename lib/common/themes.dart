import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

const Color blueColor = Color(0xff4e5ae8);
const Color whiteColor = Color(0xffffffff);
const Color blackColor = Color(0xff000000);
const Color greyColor = Color(0xff9e9e9e);
const Color lightGreyColor = Color(0xffe0e0e0);
const Color darkGreyColor = Color(0xff121212);
const Color redColor = Color(0xffe53935);
const Color yellowColor = Color(0xffef6c00);
const Color greenColor = Color(0xff43a047);
const Color darkHeaderColor = Color(0xff424242);
const primaryColor = blueColor;

class Themes{
  static final light = ThemeData(
    primaryColor: primaryColor,
    brightness: Brightness.light,
    colorScheme: const ColorScheme.light(
      primary: primaryColor,
      onPrimary: whiteColor,
      secondary: blueColor,
      onSecondary: whiteColor,
      background: whiteColor,
      onBackground: blackColor,
      surface: whiteColor,
      onSurface: blackColor,
      error: redColor,
      onError: whiteColor,
      brightness: Brightness.light,
    ),
  );

  static final dark = ThemeData(
    primaryColor: darkGreyColor,
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: darkGreyColor,
      onPrimary: whiteColor,
      secondary: blueColor,
      onSecondary: whiteColor,
      background: darkGreyColor,
      onBackground: whiteColor,
      surface: darkGreyColor,
      onSurface: whiteColor,
      error: redColor,
      onError: whiteColor,
      brightness: Brightness.dark,
    ),

  );
}

TextStyle get headingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: Get.isDarkMode ? whiteColor : blackColor
      )
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Get.isDarkMode ? Colors.grey[400] : Colors.grey[600]
      )
  );
}

TextStyle get titleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? whiteColor : blackColor
      )
  );
}

TextStyle get subtitleStyle {
  return GoogleFonts.lato(
      textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Get.isDarkMode ? Colors.grey[200]: Colors.grey[600]
      )
  );
}

TextStyle get authScreenTextStyle {
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: Colors.white
      )
  );
}

