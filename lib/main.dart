import 'package:findik_muhasebe/screens/main_screens/home_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/login_screen.dart';
import 'package:findik_muhasebe/widgets/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Provider'ı içe aktarın
import 'package:findik_muhasebe/models/user_admin.dart'; // Kullanıcı modelini içe aktarın

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()), // ThemeNotifier sağlayıcısını ekleyin
      ],
      child: MaterialApp(
        title: 'Findik Muhasebe',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: const LoginScreen(), // LoginScreen'i başlangıç ekranı yap
        routes: {
          '/home': (context) => HomeScreen(user: ModalRoute.of(context)!.settings.arguments as UserAdminModel), // Kullanıcı bilgisi ile HomeScreen
        },
      ),
    );
  }
}
