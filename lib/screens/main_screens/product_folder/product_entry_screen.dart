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
  final TextEditingController _createdIdController = TextEditingController();
  
  String? _operationType = 'stok'; 
  DateTime? _selectedDate;

  void submit() {
    final quantity = double.tryParse(_quantityController.text) ?? 0.0;
    final quality = double.tryParse(_qualityController.text) ?? 0.0;
    final owner = _ownerController.text;
    final createdId = _createdIdController.text;
    final operationType = _operationType;


    String date = _selectedDate != null ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}" : 'Tarih Seçilmedi';


    if (kDebugMode) {
      print('Operation Type: $operationType, Quantity: $quantity, Quality: $quality, Date: $date, Owner: $owner, Created ID: $createdId');
    }

    // Kaydetme işlemleri (veritabanı veya başka bir yapı)
    // ...

    // Formu sıfırlama
    _quantityController.clear();
    _qualityController.clear();
    _ownerController.clear();
    _createdIdController.clear();
    _operationType = 'stok';
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
            DropdownButtonFormField<String>(
              value: _operationType,
              items: const [
                DropdownMenuItem(value: 'stok', child: Text('Stok')),
                DropdownMenuItem(value: 'satış', child: Text('Satış')),
                DropdownMenuItem(value: 'giriş', child: Text('Giriş')),
                DropdownMenuItem(value: 'çıkış', child: Text('Çıkış')),
              ],
              onChanged: (value) {
                setState(() {
                  _operationType = value;
                });
              },
              decoration: const InputDecoration(labelText: 'İşlem Türü'),
            ),
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
              readOnly: true,
              onTap: () => _selectDate(context),
              decoration: InputDecoration(
                labelText: 'Tarih',
                hintText: _selectedDate != null
                    ? "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}"
                    : 'Tarih Seçin',
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
