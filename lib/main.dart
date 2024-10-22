import 'package:findik_muhasebe/screens/main_screens/home_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/login_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Findik Muhasebe',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: LoginScreen(), // LoginScreen'i başlangıç ekranı yap
      routes: {
        // Ana ekran rotasını tanımlayın
        '/home': (context) => HomeScreen(), // HomeScreen sınıfını uygun bir şekilde tanımlayın
      },
    );
  }
}
