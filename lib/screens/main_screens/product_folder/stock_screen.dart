// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/models/product_operations.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  late Future<List<ProductOperationsModel>> _productOperations;

  @override
  void initState() {
    super.initState();
    _productOperations = _fetchProductOperations();
  }

  Future<List<ProductOperationsModel>> _fetchProductOperations() async {
    final data = await MongoDatabase.fetchProductOperations();
    return data.map((json) => ProductOperationsModel.fromJson(json)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ProductOperationsModel>>(
        future: _productOperations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Veri yüklenirken hata oluştu: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Gösterilecek veri bulunamadı.'));
          } else {
            final operations = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: operations.length,
                itemBuilder: (context, index) {
                  final operation = operations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(operation.operationType),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Miktar: ${operation.quantity} kg'),
                          Text('Randıman: ${operation.quality} %'),
                          Text('Tarih: ${operation.createdAt.toLocal()}'),
                          Text('Kayıt Oluşturan: ${operation.createdId}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
