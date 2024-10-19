// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ayarlar Ekranı'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Kullanıcı Bilgileri'),
            Tab(text: 'Çalışan Ekle'),
            Tab(text: 'Çalışanlar'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          UserInfoTab(),
          EmployeeAddTab(),
          EmployeeListTab(),
        ],
      ),
    );
  }
}

class UserInfoTab extends StatelessWidget {
  const UserInfoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Kullanıcı Bilgileri', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Şifre'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Bilgileri güncelleme fonksiyonu
            },
            child: const Text('Güncelle'),
          ),
        ],
      ),
    );
  }
}

class EmployeeAddTab extends StatelessWidget {
  const EmployeeAddTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Text('Çalışan Ekle', style: TextStyle(fontSize: 20)),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(labelText: 'Çalışan Adı'),
          ),
          const TextField(
            decoration: InputDecoration(labelText: 'Çalışan Pozisyonu'),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Çalışanı ekleme fonksiyonu
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }
}

class EmployeeListTab extends StatelessWidget {
  const EmployeeListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 5, // Örnek veri sayısı
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Çalışan ${index + 1}'),
              subtitle: Text('Pozisyon: Pozisyon ${index + 1}'), // Örnek veri
              trailing: const Icon(Icons.arrow_forward),
              onTap: () {
                // Çalışan detaylarına gitmek için fonksiyon
              },
            ),
          );
        },
      ),
    );
  }
}
