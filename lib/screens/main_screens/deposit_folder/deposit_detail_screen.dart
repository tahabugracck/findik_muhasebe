import 'package:findik_muhasebe/models/deposit.dart';
import 'package:flutter/material.dart';

class DepositDetailScreen extends StatelessWidget {
  final DepositModel deposit;

  const DepositDetailScreen({super.key, required this.deposit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emanet Detayları'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Emanet Adı: ${deposit.itemName}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Miktar: ${deposit.quantity}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('İşlem Tarihi: ${deposit.transactionDate.toLocal().toString().split(' ')[0]}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Durum: ${deposit.status ? 'Aktif' : 'İade Edildi'}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Açıklama: ${deposit.description}', style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
