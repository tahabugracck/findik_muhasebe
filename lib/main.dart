import 'package:findik_muhasebe/screens/main_screens/home_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/login_screen.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:findik_muhasebe/widgets/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:findik_muhasebe/models/user_admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MongoDatabase.connect();


try {
    final currents = await MongoDatabase.fetchCurrentMovements();
    if (currents.isEmpty) {
      if (kDebugMode) {
        print('No current movements found.');
      }
    } else {
      for (var current in currents) {
        if (kDebugMode) {
          print(current);
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching current movements: $e');
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) =>
                ThemeNotifier()), // ThemeNotifier sağlayıcısını ekledik
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            title: 'Fındık Muhasebe',
            theme: themeNotifier.currentTheme, // Geçerli temayı al
            home: const LoginScreen(), // LoginScreen'i başlangıç ekranı yap
            routes: {
              '/home': (context) => HomeScreen(
                  user: ModalRoute.of(context)!.settings.arguments
                      as UserAdminModel), // Kullanıcı bilgisi ile HomeScreen
            },
          );
        },
      ),
    );
  }
}
