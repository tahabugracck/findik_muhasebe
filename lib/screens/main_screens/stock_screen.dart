import 'package:flutter/material.dart';

class StockScreen extends StatelessWidget {
  const StockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stok Ekranı'),
      ),
      body: Padding(
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
    );
  }
}
