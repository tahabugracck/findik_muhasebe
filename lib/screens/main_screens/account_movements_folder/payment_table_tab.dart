// Tahsilat

// payment_table_tab.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/models/payments.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:intl/intl.dart'; // Tarih formatlamak için

class PaymentTableTab extends StatefulWidget {
  const PaymentTableTab({super.key});

  @override
  _PaymentTableTabState createState() => _PaymentTableTabState();
}

class _PaymentTableTabState extends State<PaymentTableTab> {
  late Future<List<PaymentsModel>> _paymentsMovements;

  @override
  void initState() {
    super.initState();
    _paymentsMovements = MongoDatabase.fetchPaymentsMovements();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<PaymentsModel>>(
        future: _paymentsMovements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç veri yok.'));
          } else {
            final paymentsMovements = snapshot.data!;
            return ListView.builder(
              itemCount: paymentsMovements.length,
              itemBuilder: (context, index) {
                final payment = paymentsMovements[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text('Tahsilat: ${payment.amount} TL'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Açıklama: ${payment.description}'),
                        Text('Tahsilat Tarihi: ${DateFormat('dd/MM/yyyy').format(payment.collectionDate)}'),
                        Text('Oluşturma Tarihi: ${DateFormat('dd/MM/yyyy').format(payment.createdAt)}'),
                        //Text('Müşteri ID: ${payment.customerId}'),
                        //Text('Oluşturan ID: ${payment.createdBy}'),
                        Text('Ödeme Yöntemi: ${payment.method}'),
                      ],
                    ),
                    trailing: Text('ID: ${payment.id}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
