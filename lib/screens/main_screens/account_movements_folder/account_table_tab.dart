// Cari Hareketler sekmesi

// account_table_tab.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:findik_muhasebe/models/current_movements.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:intl/intl.dart';

class AccountTableTab extends StatefulWidget {
  const AccountTableTab({super.key});

  @override
  _AccountTableTabState createState() => _AccountTableTabState();
}

class _AccountTableTabState extends State<AccountTableTab> {
  late Future<List<CurrentMovementsModel>> _currentMovements;

  @override
  void initState() {
    super.initState();
    _currentMovements = MongoDatabase.fetchCurrentMovements();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<CurrentMovementsModel>>(
        future: _currentMovements,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Hata: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Hiç veri yok.'));
          } else {
            final currentMovements = snapshot.data!;
            return ListView.builder(
              itemCount: currentMovements.length,
              itemBuilder: (context, index) {
                final movement = currentMovements[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    title: Text(
                        'İşlem Türü: ${movement.transactionType.toUpperCase()}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Açıklama: ${movement.description}'),
                        Text('İşlem Tarihi: ${DateFormat('dd/MM/yyyy').format(movement.transactionDate)}'),
                        Text('Oluşturma Tarihi: ${DateFormat('dd/MM/yyyy').format(movement.createdAt)}'),
                        //Text('Müşteri ID: ${movement.customerId}'),
                        //Text('Oluşturan ID: ${movement.createdId}'),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Miktar: ${movement.amount} TL'),
                        Text('Bakiye: ${movement.balanceAfterTransaction} TL'),
                      ],
                    ),
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
