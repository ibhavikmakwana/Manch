import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_playground/values/app_colors.dart';

class AppTheme {
  static ThemeData? lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.screenBackground,
    primaryColor: AppColors.primaryColor,
    accentColor: Colors.white,
    cardColor: Colors.white,
    buttonColor: AppColors.primaryColor,
    bottomAppBarColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: AppColors.screenBackground,
      elevation: 4,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: AppColors.dark,
      indicatorSize: TabBarIndicatorSize.label,
      unselectedLabelColor: AppColors.gray,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(28),
        borderSide: BorderSide.none,
      ),
    ),
    fontFamily: GoogleFonts.nunitoSans().fontFamily,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 4,
      backgroundColor: Colors.white,
      showUnselectedLabels: false,
      showSelectedLabels: true,
      selectedLabelStyle: TextStyle(color: AppColors.primaryColor),
      selectedItemColor: AppColors.dark,
      unselectedItemColor: AppColors.gray,
      type: BottomNavigationBarType.fixed,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      shape: CircularNotchedRectangle(),
      elevation: 4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size.fromHeight(48)),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        ),
      ),
    ),
  );
}
