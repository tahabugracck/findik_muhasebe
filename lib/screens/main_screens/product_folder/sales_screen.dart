import 'package:flutter/material.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Satış Ekranı'),
      ),
      body: Padding(
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
    );
  }
}
