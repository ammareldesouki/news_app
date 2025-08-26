import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      backgroundColor: Colors.white,

      padding: const EdgeInsets.symmetric(vertical: 18),
      textStyle: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );


    static final darkElevatedButtonTheme = ElevatedButtonThemeData(
         style: ElevatedButton.styleFrom(
      elevation: 0,
           backgroundColor: Colors.black,

      padding: const EdgeInsets.symmetric(vertical: 18),
           textStyle: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}
