// employee_add_tab.dart
// ignore_for_file: library_private_types_in_public_api, prefer_final_fields

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EmployeeAddTab extends StatefulWidget {
  const EmployeeAddTab({super.key});

  @override
  _EmployeeAddTabState createState() => _EmployeeAddTabState();
}

class _EmployeeAddTabState extends State<EmployeeAddTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _screens = ['Müşteri Ekranı', 'Cari Hareketler', 'Fabrika ve Emanet İşlemleri', 'Ürün İşlemleri', 'Kasa İşlemleri', 'Rapor Ekranı', 'Fiyat Güncelle'];
  List<bool> _selectedScreens = [false, false, false, false, false, false, false];

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _addEmployee() {
    String name = _nameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool isAdmin = false;

    List<String> accessibleScreens = [];
    for (int i = 0; i < _screens.length; i++) {
      if (_selectedScreens[i]) {
        accessibleScreens.add(_screens[i]);
      }
    }

    if (kDebugMode) {
      print('Çalışan Adı: $name');
    }
    if (kDebugMode) {
      print('Kullanıcı Adı: $username');
    }
    if (kDebugMode) {
      print('Şifre: $password');
    }
    if (kDebugMode) {
      print('Admin mi: $isAdmin');
    }
    if (kDebugMode) {
      print('Erişebileceği Ekranlar: $accessibleScreens');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          const Text('Çalışan Ekle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Çalışan Adı',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: 'Kullanıcı Adı',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          const Text('Erişebileceği Ekranlar', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Column(
            children: List.generate(_screens.length, (index) {
              return CheckboxListTile(
                title: Text(_screens[index]),
                value: _selectedScreens[index],
                onChanged: (bool? value) {
                  setState(() {
                    _selectedScreens[index] = value ?? false;
                  });
                },
              );
            }),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: _addEmployee,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Çalışanı Ekle'),
            ),
          ),
        ],
      ),
    );
  }
}
