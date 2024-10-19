// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CashScreen extends StatefulWidget {
  const CashScreen({super.key});

  @override
  _CashScreenState createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Kasa İşlemleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Kart'),
            Tab(text: 'Nakit'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CashTab(tabType: 'Kart'),
          CashTab(tabType: 'Nakit'),
        ],
      ),
    );
  }
}

class CashTab extends StatelessWidget {
  final String tabType;

  const CashTab({super.key, required this.tabType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Gelir/Gider ekleme fonksiyonu
          },
          child: Text('$tabType Gelir/Gider Ekle'),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Örnek veri sayısı
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text('$tabType İşlem ${index + 1}'),
                  subtitle: Text('Tutar: ${index * 50} TL'), // Örnek veri
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // İşlem detaylarına gitmek için fonksiyon
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
