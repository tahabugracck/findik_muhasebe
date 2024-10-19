// emanet ekranı

import 'package:flutter/material.dart';

class EmanetScreen extends StatelessWidget {
  const EmanetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emanet İşlemleri'),
      ),
      body: Padding(
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
    );
  }
}
