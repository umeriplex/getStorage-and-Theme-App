import 'package:flutter/material.dart';

class Themes{

  static final light = ThemeData.light().copyWith(
  appBarTheme:const AppBarTheme(
    backgroundColor: primaryClr,
  ),
  brightness: Brightness.light,
);

static final dark = ThemeData.dark().copyWith(
  appBarTheme:const AppBarTheme(
    backgroundColor: darkHeaderClr,
  ),
  brightness: Brightness.dark,
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