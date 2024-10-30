


// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/models/current_movements.dart';
import 'package:findik_muhasebe/models/payments.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/material.dart';

class AccountMovementsScreen extends StatefulWidget {
  const AccountMovementsScreen({super.key});

  @override
  _AccountMovementsScreenState createState() => _AccountMovementsScreenState();
}

class _AccountMovementsScreenState extends State<AccountMovementsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    await MongoDatabase.connect();
  }

  @override
  void dispose() {
    _tabController.dispose();
    MongoDatabase.close(); // Ensure to close the connection
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Hareketler'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Cari Tablo'),
            Tab(text: 'Tahsilat Tablosu'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          AccountTableTab(),
          PaymentTableTab(),
        ],
      ),
    );
  }
}

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
                    title: Text('Cari Hareket: ${movement.title}'), // Adjust based on your model
                    subtitle: Text('Açıklama: ${movement.description}'), // Adjust based on your model
                    trailing: Text('${movement.amount} TL'), // Adjust based on your model
                    onTap: () {
                      // Cari hareket detaylarına gitmek için fonksiyon
                    },
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
                    title: Text('Tahsilat: ${payment.title}'), // Adjust based on your model
                    subtitle: Text('Açıklama: ${payment.description}'), // Adjust based on your model
                    trailing: Text('${payment.amount} TL'), // Adjust based on your model
                    onTap: () {
                      // Tahsilat detaylarına gitmek için fonksiyon
                    },
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
