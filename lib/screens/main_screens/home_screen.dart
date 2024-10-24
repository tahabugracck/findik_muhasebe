// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/models/user_admin.dart';
import 'package:findik_muhasebe/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final UserAdminModel user; // Kullanıcı bilgisini al

  const HomeScreen({super.key, required this.user}); // Yapıcı metodunu güncelle

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _selectedPage = const Center(
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ana Sayfa'),
      ),
      drawer: CustomDrawer(
        hasMobileScreen: true,
        user: widget.user, // Kullanıcı bilgisini geç
        onMenuItemSelected: (Widget page) {
          setState(() {
            _selectedPage = page; // Seçilen sayfayı günceller
          });
          Navigator.of(context).pop(); // Menüyü kapat
        },
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'), // Resim dosyasının yolu
            fit: BoxFit.cover, // Resmi kapsamak için
          ),
        ),
        child: _selectedPage,
      ),
    );
  }
}
