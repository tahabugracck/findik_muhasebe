import 'package:flutter/material.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Müşteri Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: 10, // Örnek veri sayısı
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text('Müşteri ${index + 1}'),
                subtitle: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Bakiye: 1000 TL'),
                    Text('Borç: 200 TL'),
                    Text('Ödemeler: 300 TL'),
                  ],
                ),
                trailing: const Icon(Icons.arrow_forward),
                onTap: () {
                  // Müşteri detaylarına gitmek için fonksiyon
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
