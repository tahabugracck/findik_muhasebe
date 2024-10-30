// ignore_for_file: library_private_types_in_public_api

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


try {
    final payments = await MongoDatabase.fetchPaymentsMovements();
    if (payments.isEmpty) {
      if (kDebugMode) {
        print('No payments movements found.');
      }
    } else {
      for (var payment in payments) {
        if (kDebugMode) {
          print(payment);
        }
      }
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching payment movements: $e');
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
          home: const LoginScreen(), // Counter widget'ını başlangıç ekranı yap

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
class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('$_counter', style: Theme.of(context).textTheme.headlineMedium), // Sayacın değerini göster
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _incrementCounter, // Butona tıklanınca sayacı artır
          ),
        ],
      ),
    );
  }
}
