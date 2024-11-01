// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/screens/main_screens/product_folder/product_entry_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/product_folder/sales_screen.dart';
import 'package:findik_muhasebe/screens/main_screens/product_folder/stock_screen.dart';
import 'package:flutter/material.dart';

class ProductOperationsScreen extends StatefulWidget {
  const ProductOperationsScreen({super.key});

  @override
  _ProductOperationsScreenState createState() =>
      _ProductOperationsScreenState();
}

class _ProductOperationsScreenState extends State<ProductOperationsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        title: const Text('Ürün İşlemleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Stok'),
            Tab(text: 'Satış'),
            Tab(text: 'Ürün Girişi'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          StockScreen(),
          SalesScreen(),
          ProductEntryScreen(),
        ],
      ),
    );
  }
}
