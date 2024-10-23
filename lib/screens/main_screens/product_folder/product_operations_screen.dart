// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class ProductOperationsScreen extends StatefulWidget {
  const ProductOperationsScreen({super.key});

  @override
  _ProductOperationsScreenState createState() => _ProductOperationsScreenState();
}

class _ProductOperationsScreenState extends State<ProductOperationsScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Ürün İşlemleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Stok'),
            Tab(text: 'Satış'),
            Tab(text: 'Ürün Girişi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Stok Ekranı
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: 5, // Örnek veri sayısı
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text('Müşteri ${index + 1}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Fındık Miktarı: ${index * 10} kg'), // Örnek veri
                      ],
                    ),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      // Müşteri stok detaylarına gitmek için fonksiyon
                    },
                  ),
                );
              },
            ),
          ),

          // Satış Ekranı
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Satış ekleme fonksiyonu
                  },
                  child: const Text('Yeni Satış Ekle'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Örnek veri sayısı
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Satış ${index + 1}'),
                          subtitle: Text('Miktar: ${index * 10} kg'), // Örnek veri
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Satış detaylarına gitmek için fonksiyon
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // Ürün Girişi Ekranı
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Miktar (kg)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Randıman (%)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Tarih (gg/aa/yyyy)'),
                ),
                TextField(
                  controller: TextEditingController(),
                  decoration: const InputDecoration(labelText: 'Fındık Sahibi'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    // Ürün girişini kaydetme işlemi
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Ürün girişi başarıyla kaydedildi!')),
                    );
                  },
                  child: const Text('Girişi Kaydet'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
