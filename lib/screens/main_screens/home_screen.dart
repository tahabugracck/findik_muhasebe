// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/widgets/custom_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedPage = const Center(
    child: Text(
      'Hoşgeldiniz, burası ana sayfanız!',
      style: TextStyle(fontSize: 24),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      drawer: CustomDrawer(
        hasMobileScreen: true,
        onMenuItemSelected: (Widget page) {
          setState(() {
            _selectedPage = page; // Seçilen sayfayı günceller
          });
          Navigator.of(context).pop(); // Menüyü kapat
        },
      ),
      body: _selectedPage,
    );
  }
}
