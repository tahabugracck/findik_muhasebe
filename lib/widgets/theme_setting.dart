import 'package:flutter/material.dart';

class ThemeSetting {
  // Karanlık Tema
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
      foregroundColor: Colors.white,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[850], // Menü arka planı
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[800], // Buton arka planı
      ),
    ),
  );

  // Beyaz Tema
  static final ThemeData whiteTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[200],
      foregroundColor: Colors.black,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: Colors.grey[300], // Menü arka planı
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[200], // Buton arka planı
      ),
    ),
  );

  // Özelleştirilmiş Standart Tema
  static final ThemeData standardTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF9CBF50), // #9CBF50
    hintColor: const Color(0xFF8C2703), // #8C2703
    scaffoldBackgroundColor: const Color(0xFFBF6E50), // #BF6E50
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF83A603), // #83A603
      foregroundColor: Colors.white,
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: Color(0xFF9CBF50), // Menü arka planı
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Color(0xFFF2F2F2)), // #F2F2F2
      bodyMedium: TextStyle(color: Color(0xFFF2F2F2)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF83A603), // Buton arka planı #83A603
        foregroundColor: const Color(0xFFF2F2F2), // Yazı rengi #F2F2F2
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFFBF6E50), // Input arka planı #BF6E50
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0xFF9CBF50), // Sınır rengi #9CBF50
        ),
      ),
      labelStyle: TextStyle(
        color: Color(0xFFF2F2F2), // Etiket rengi #F2F2F2
      ),
    ),
  );
}
