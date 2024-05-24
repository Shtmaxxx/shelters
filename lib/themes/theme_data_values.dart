import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ThemeDataValues {
  ThemeData get defaultThemeData => ThemeData(
        fontFamily: GoogleFonts.rubik().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: const Color(0xFF4d52e3),
          centerTitle: true,
          elevation: 0,
          foregroundColor: Colors.white,
          titleTextStyle: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        scaffoldBackgroundColor: const Color(0xFFefedf2),
        primaryColor: const Color(0xFF4d52e3),
        primaryColorDark: const Color(0xFF2b2fb3),
        primaryColorLight: const Color(0xff9598ed),
        hintColor: const Color(0xff97979B),
        canvasColor: const Color(0xffC4D1E0),
        primaryTextTheme: TextTheme(
          titleLarge: GoogleFonts.rubik(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: GoogleFonts.rubik(
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
          displayLarge: GoogleFonts.rubik(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ).apply(
          bodyColor: const Color(0xFF1C1243),
          displayColor: const Color(0xFF1C1243),
        ),
      );
}
