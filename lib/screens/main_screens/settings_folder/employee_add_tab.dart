// ignore_for_file: use_build_context_synchronously, library_private_types_in_public_api

import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/material.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // Base64 encoding

class EmployeeAddTab extends StatefulWidget {
  const EmployeeAddTab({super.key});

  @override
  _EmployeeAddTabState createState() => _EmployeeAddTabState();
}

class _EmployeeAddTabState extends State<EmployeeAddTab> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final List<String> _screens = [
    'Müşteri Ekranı',
    'Cari Hareketler',
    'Fabrika ve Emanet İşlemleri',
    'Ürün İşlemleri',
    'Kasa İşlemleri',
    'Rapor Ekranı',
    'Fiyat Güncelle'
  ];
  
  List<bool> _selectedScreens = [false, false, false, false, false, false, false];

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String _hashPassword(String password) {
    // SHA-256 ile şifreyi hashle
    final bytes = utf8.encode(password);
    final digest = sha256.convert(bytes);
    return digest.toString(); // Hash'lenmiş şifreyi döndür
  }

  void _addEmployee() async {
    String name = _nameController.text;
    String username = _usernameController.text;
    String password = _passwordController.text;
    bool isAdmin = false;

    // Erişebileceği ekranları oluştur
    Map<String, bool> accessRights = {
      'customer': _selectedScreens[0],
      'accountMovements': _selectedScreens[1],
      'entrustedAndFactoryOperations': _selectedScreens[2],
      'productOperations': _selectedScreens[3],
      'cashOperations': _selectedScreens[4],
      'report': _selectedScreens[5],
      'priceUpdate': _selectedScreens[6],
      'settings': false, // Ayarlar varsayılan olarak false
      'invoiceOperations': false // Fatura işlemleri varsayılan olarak false
    };

    // Şifreyi hashle
    String hashedPassword = _hashPassword(password);

    // Çalışan verilerini topla
    Map<String, dynamic> employeeData = {
      'name': name,
      'username': username,
      'password': hashedPassword, // Hash'lenmiş şifreyi ekle
      'admin': isAdmin,
      'accessRights': accessRights,
    };

    // Veritabanına ekleme işlemi
    await MongoDatabase.addEmployee(employeeData);

    // Başarı durumunda kullanıcıya bildirim
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Çalışan başarıyla eklendi!')),
    );

    // Formu temizle
    _nameController.clear();
    _usernameController.clear();
    _passwordController.clear();
    setState(() {
      _selectedScreens = [false, false, false, false, false, false, false]; // Seçimleri sıfırla
    });
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
