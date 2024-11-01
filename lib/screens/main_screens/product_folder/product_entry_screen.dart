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
  final TextEditingController _ownerController = TextEditingController();
  DateTime? _selectedDate;

  void submit() {
    // Ürün girişini kaydetme işlemi
    final quantity = _quantityController.text;
    final quality = _qualityController.text;
    final owner = _ownerController.text;

    // Tarih formatını ayarlama
    String date = _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : 'Tarih Seçilmedi';

    // Example usage of the variables
    if (kDebugMode) {
      print('Quantity: $quantity, Quality: $quality, Date: $date, Owner: $owner');
    }

    // Kaydetme işlemleri (veritabanı veya başka bir yapı)
    // ...

    // Formu sıfırlama
    _quantityController.clear();
    _qualityController.clear();
    _ownerController.clear();
    _selectedDate = null;

    // Başarılı bir şekilde kaydedildi mesajı
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ürün girişi başarıyla kaydedildi!')),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              readOnly: true, // Kullanıcının tarih alanını doğrudan değiştirmesini engeller
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Tarih',
                hintText: _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : 'Tarih Seçin',
                suffixIcon: const Icon(Icons.calendar_today),
              ),
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
