import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

//?Blue White Theme
ThemeData whiteTheme = ThemeData(
  primaryColor: const Color(0xff7440ff),
  focusColor: const Color(0xff00FFB7),
  indicatorColor: const Color(0xff11034a),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.light,
    foregroundColor: Colors.black,
    color: Colors.white,
    elevation: 0,
    toolbarHeight: 50,
    titleSpacing: 2,
    titleTextStyle: TextStyle(fontSize: 17, color: Colors.black),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    fillColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black; // the color when checkbox is selected;
        }
        return Colors.black; //the color when checkbox is unselected;
      },
    ),
  ),
  chipTheme: ChipThemeData(
    selectedColor: Colors.grey.shade100,
  ),
  textTheme: GoogleFonts.poppinsTextTheme(),
  // textTheme: GoogleFonts.montserratTextTheme(),
);

//?Blue Dark Theme
ThemeData darkTheme = ThemeData(
  cardColor: const Color(0xff343145),
  primaryColor: const Color(0xff3362FB),
  indicatorColor: Colors.white,
  focusColor: const Color(0xffF5F5F5),
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    foregroundColor: Colors.white,
    color: Color(0xff272536),
    elevation: 0,
    toolbarHeight: 50,
    titleSpacing: 2,
    titleTextStyle: TextStyle(fontSize: 17, color: Colors.white),
  ),
  bottomAppBarTheme: const BottomAppBarTheme(
    color: Color(0xff272536),
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xff272536),
  ),
  checkboxTheme: CheckboxThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
    fillColor: MaterialStateColor.resolveWith(
      (states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black; // the color when checkbox is selected;
        }
        return Colors.black; //the color when checkbox is unselected;
      },
    ),
    checkColor: MaterialStateProperty.all(
      const Color(0xff00FFBA),
    ),
  ),
  chipTheme: const ChipThemeData(
    selectedColor: Color.fromARGB(255, 52, 48, 70),
  ),
  iconTheme: const IconThemeData(color: Colors.white),
  textTheme: GoogleFonts.poppinsTextTheme()
      .apply(bodyColor: Colors.white)
      .copyWith(titleMedium: const TextStyle(color: Colors.white)),
);
