// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductEntryScreen extends StatefulWidget {
  const ProductEntryScreen({super.key});

  @override
  _ProductEntryScreenState createState() => _ProductEntryScreenState();
}

class _ProductEntryScreenState extends State<ProductEntryScreen> {
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _qualityController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _ownerController = TextEditingController();

  void submit() {
    // Ürün girişini kaydetme işlemi
    final quantity = _quantityController.text;
    final quality = _qualityController.text;
    final date = _dateController.text;
    final owner = _ownerController.text;

    // Example usage of the variables
    if (kDebugMode) {
      print('Quantity: $quantity, Quality: $quality, Date: $date, Owner: $owner');
    }

    // Kaydetme işlemleri (veritabanı veya başka bir yapı)
    // ...

    // Formu sıfırlama
    _quantityController.clear();
    _qualityController.clear();
    _dateController.clear();
    _ownerController.clear();

    // Başarılı bir şekilde kaydedildi mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ürün girişi başarıyla kaydedildi!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Girişi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _quantityController,
              decoration: const InputDecoration(labelText: 'Miktar (kg)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _qualityController,
              decoration: const InputDecoration(labelText: 'Randıman (%)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _dateController,
              decoration: const InputDecoration(labelText: 'Tarih (gg/aa/yyyy)'),
            ),
            TextField(
              controller: _ownerController,
              decoration: const InputDecoration(labelText: 'Fındık Sahibi'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submit,
              child: const Text('Girişi Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
