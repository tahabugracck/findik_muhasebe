import 'package:flutter/material.dart';

class FactoryOperationsScreen extends StatelessWidget {
  const FactoryOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fabrika İşlemleri'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Fındık alım işlemi
              },
              child: const Text('Fındık Al'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Fındık işleme işlemi
              },
              child: const Text('Fındık İşle'),
            ),
            const SizedBox(height: 20),
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
    );
  }
}
