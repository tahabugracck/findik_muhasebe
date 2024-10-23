// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class EntrustedAndFactoryOperationsScreen extends StatefulWidget {
  const EntrustedAndFactoryOperationsScreen({super.key});

  @override
  _EntrustedAndFactoryOperationsScreenState createState() => _EntrustedAndFactoryOperationsScreenState();
}

class _EntrustedAndFactoryOperationsScreenState extends State<EntrustedAndFactoryOperationsScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Fabrika ve Emanet İşlemleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Fabrika İşlemleri'),
            Tab(text: 'Emanet İşlemleri'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Fabrika İşlemleri Sekmesi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Fındık alım işlemi
                  },
                  child: const Text('Fındık Al'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Fındık işleme işlemi
                  },
                  child: const Text('Fındık İşle'),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Fındık gönderme işlemi
                  },
                  child: const Text('Fındık Gönder'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Örnek veri sayısı
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Fındık İşlemi ${index + 1}'),
                          subtitle: Text('Detay: İşlem Detayı ${index + 1}'), // Örnek veri
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
            ),
          ),

          // Emanet İşlemleri Sekmesi
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Emanet ekleme fonksiyonu
                  },
                  child: const Text('Emanet Ekle'),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: ListView.builder(
                    itemCount: 10, // Örnek veri sayısı
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8.0),
                        child: ListTile(
                          title: Text('Emanet ${index + 1}'),
                          subtitle: Text('Miktar: ${index * 10} kg'), // Örnek veri
                          trailing: const Icon(Icons.arrow_forward),
                          onTap: () {
                            // Emanet detaylarına gitmek için fonksiyon
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
