// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class AddMovementScreen extends StatefulWidget {
  final Function(Map<String, dynamic>) onSubmit;

  const AddMovementScreen({super.key, required this.onSubmit});

  @override
  _AddMovementScreenState createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen> {
  final _formKey = GlobalKey<FormState>();
  String toFrom = '';
  String transactionType = 'Gelir';
  String type = 'Nakit';
  String amount = '';
  String transactionDate = '';
  String description = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Alıcı / Verici'),
            onSaved: (value) {
              toFrom = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan zorunludur';
              }
              return null;
            },
          ),
          DropdownButtonFormField<String>(
            value: transactionType,
            decoration: const InputDecoration(labelText: 'İşlem Türü'),
            items: const [
              DropdownMenuItem(value: 'Gelir', child: Text('Gelir')),
              DropdownMenuItem(value: 'Gider', child: Text('Gider')),
            ],
            onChanged: (value) {
              setState(() {
                transactionType = value!;
              });
            },
          ),
          DropdownButtonFormField<String>(
            value: type,
            decoration: const InputDecoration(labelText: 'Tür'),
            items: const [
              DropdownMenuItem(value: 'Nakit', child: Text('Nakit')),
              DropdownMenuItem(value: 'Kart', child: Text('Kart')),
            ],
            onChanged: (value) {
              setState(() {
                type = value!;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Tutar'),
            keyboardType: TextInputType.number,
            onSaved: (value) {
              amount = value ?? '';
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Bu alan zorunludur';
              }
              if (double.tryParse(value) == null) {
                return 'Geçerli bir sayı girin';
              }
              return null;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Tarih (dd/MM/yyyy)'),
            onSaved: (value) {
              transactionDate = value ?? '';
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Açıklama'),
            onSaved: (value) {
              description = value ?? '';
            },
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                widget.onSubmit({
                  'to_from': toFrom,
                  'transactionType': transactionType,
                  'type': type,
                  'amount': double.tryParse(amount) ?? 0.0,
                  'transactionDate': transactionDate,
                  'description': description,
                });
              }
            },
            child: const Text('Ekle'),
          ),
        ],
      ),
    );
  }
}
