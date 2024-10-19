// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AccountMovementsScreen extends StatefulWidget {
  const AccountMovementsScreen({super.key});

  @override
  _AccountMovementsScreenState createState() => _AccountMovementsScreenState();
}

class _AccountMovementsScreenState extends State<AccountMovementsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: const Text('Cari Hareketler'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cari Tablo'),
            Tab(text: 'Tahsilat Tablosu'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AccountTableTab(),
          PaymentTableTab(),
        ],
      ),
    );
  }
}

class AccountTableTab extends StatelessWidget {
  const AccountTableTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 10, // Örnek veri sayısı
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Cari Hareket ${index + 1}'),
              subtitle: Text('Açıklama: Hareket Detayı ${index + 1}'), // Örnek veri
              trailing: Text('${index * 50} TL'), // Örnek veri
              onTap: () {
                // Cari hareket detaylarına gitmek için fonksiyon
              },
            ),
          );
        },
      ),
    );
  }
}

class PaymentTableTab extends StatelessWidget {
  const PaymentTableTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.builder(
        itemCount: 10, // Örnek veri sayısı
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text('Tahsilat ${index + 1}'),
              subtitle: Text('Açıklama: Tahsilat Detayı ${index + 1}'), // Örnek veri
              trailing: Text('${index * 30} TL'), // Örnek veri
              onTap: () {
                // Tahsilat detaylarına gitmek için fonksiyon
              },
            ),
          );
        },
      ),
    );
  }
}
