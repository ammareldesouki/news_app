
import 'package:flutter/material.dart';
import 'package:news_app/core/theme/widget_themes/appbar_theme.dart';
import 'package:news_app/core/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:news_app/core/theme/widget_themes/checkbox_theme.dart';
import 'package:news_app/core/theme/widget_themes/elevated_button_theme.dart';
import 'package:news_app/core/theme/widget_themes/text_theme.dart';
import '../constants/colors.dart';


class TAppTheme {
  TAppTheme._();
  static ThemeData lightAppTheme = ThemeData(
 useMaterial3: true,
 
 scaffoldBackgroundColor: TColors.light,
 fontFamily: 'Inter',
 brightness: Brightness.light,

 textTheme:TTextTheme.lightTextTheme,
elevatedButtonTheme: TElevatedButtonTheme.lightElevatedButtonTheme,
appBarTheme: TAppbarTheme.lightAppBarTheme,
checkboxTheme: TCheckboxTheme.lightCheckboxTheme,
bottomNavigationBarTheme: BottomNavTheme.light,






  );

  static ThemeData darkAppTheme = ThemeData(
     useMaterial3: true,
 scaffoldBackgroundColor: TColors.dark,
 fontFamily: 'Inter',
 brightness: Brightness.dark,
 primaryColor: TColors.primary,
 textTheme:TTextTheme.darkTextTheme,
 elevatedButtonTheme: TElevatedButtonTheme.darkElevatedButtonTheme,
 appBarTheme:  TAppbarTheme.darkAppBarTheme,
 checkboxTheme: TCheckboxTheme.darkCheckboxTheme,
 bottomNavigationBarTheme:BottomNavTheme.dark,



  );
}
