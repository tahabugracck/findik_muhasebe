// account_movements_screen.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'account_table_tab.dart';
import 'payment_table_tab.dart';

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
  }

  @override
  void dispose() {
    _tabController.dispose();
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
