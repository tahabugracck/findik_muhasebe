import 'package:flutter/material.dart';

class PriceUpdateScreen extends StatelessWidget {
  final double currentPrice = 150.0;

  const PriceUpdateScreen({super.key}); // Örnek mevcut fiyat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fiyat Güncelle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Mevcut Fındık Fiyatı: $currentPrice TL',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fiyat güncelleme fonksiyonu
              },
              child: const Text('Fiyatı Güncelle'),
            ),
          ],
        ),
      ),
    );
  }
}
