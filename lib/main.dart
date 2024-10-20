import 'package:findik_muhasebe/screens/main_screens/home_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:findik_muhasebe/services/mongodb.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // MongoDB bağlantısını başlat
  await MongoDatabase.connect();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fındık Muhasebe', 
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Uygulamanın başlangıç ekranı LoginScreen olacak
      home: const HomeScreen(),
      // Rota tanımlamaları
      routes: {
        '/admin': (context) => const HomeScreen(), // Eğer toptancı ekranı tanımlandıysa
      },
    );
  }
}
