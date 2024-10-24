// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/widgets/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          indicatorColor: Colors.white,
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
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Kullanıcı Bilgileri', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Kullanıcı Adı',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Şifre',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Bilgileri güncelleme fonksiyonu
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Güncelle'),
            ),
          ),
          const SizedBox(height: 40),
          const Text('Tema Değiştir', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  themeNotifier.setDarkTheme();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text('Koyu Tema'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeNotifier.setWhiteTheme();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text('Açık Tema'),
              ),
              ElevatedButton(
                onPressed: () {
                  themeNotifier.setStandardTheme();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
                child: const Text('Standart Tema'),
              ),
            ],
          ),
          const SizedBox(height: 40),
          const Text('Hakkında', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          ListTile(
            title: const Text('Uygulama Hakkında', style: TextStyle(fontSize: 16)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Hakkında'),
                    content: const Text(
                      'Uygulama Versiyonu: 1.0.0\nGeliştirici: Taha Buğra Çiçek',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Tamam'),
                      ),
                    ],
                  );
                },
              );
            },
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Çalışan Ekle', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Çalışan Adı',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Çalışan Pozisyonu',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              onPressed: () {
                // Çalışanı ekleme fonksiyonu
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Ekle'),
            ),
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
