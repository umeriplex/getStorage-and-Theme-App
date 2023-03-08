import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{

  static final light = ThemeData.light().copyWith(
  appBarTheme:const AppBarTheme(
    backgroundColor: primaryClr,
  ),
  backgroundColor: Colors.white,
  brightness: Brightness.light,
);

static final dark = ThemeData.dark().copyWith(
  appBarTheme:const AppBarTheme(
    backgroundColor: darkHeaderClr,
  ),
  brightness: Brightness.dark,
  backgroundColor: darkGreyClr,
);

}
const bluishClr = Colors.blue;
const Color yellowClr = Color (0xFFFFB746);
const Color pinkClr = Color (0xFFff4667);
const Color white = Colors.white;
const primaryClr = bluishClr;
const Color darkGreyClr = Color (0xFF121212);
const Color darkHeaderClr = Color (0xFF424242);
// static final light = ThemeData.light().copyWith(
//   appBarTheme:const AppBarTheme(
//     backgroundColor: primaryClr,
//   ),
//   brightness: Brightness.light,
// );
//
// static final dark = ThemeData.dark().copyWith(
//   appBarTheme:const AppBarTheme(
//     backgroundColor: darkGreyClr,
//   ),
//   brightness: Brightness.dark,
// );



TextStyle get headingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: Get.isDarkMode ? Colors.white : Colors.black,
    ),
  );
}

TextStyle get subHeadingStyle {
  return GoogleFonts.lato(
    textStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w800,
      color: Get.isDarkMode ? Colors.grey[400] : Colors.grey,
    ),
  );
}

TextStyle get normalTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  );
}

TextStyle get smallTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w300,
    ),
  );
}

TextStyle get verySmallTextStyle {
  return GoogleFonts.lato(
    textStyle: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w300,
    ),
  );
}

extension Padding on num{
  SizedBox get pw => SizedBox(width: toDouble(),);
  SizedBox get ph => SizedBox(height: toDouble(),);
}