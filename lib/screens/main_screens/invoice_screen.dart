  import 'package:flutter/material.dart';

  class InvoiceScreen extends StatelessWidget {
    const InvoiceScreen({super.key});

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Fatura İşlemleri'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Fatura ekleme fonksiyonu
                },
                child: const Text('Fatura Ekle'),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: 10, // Örnek veri sayısı
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: ListTile(
                        title: Text('Fatura ${index + 1}'),
                        subtitle: Text('Tutar: ${index * 100} TL'), // Örnek veri
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          // Fatura detaylarına gitmek için fonksiyon
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
