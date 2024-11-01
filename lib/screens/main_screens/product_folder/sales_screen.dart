// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:findik_muhasebe/models/product_operations.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({super.key});

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {
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

  Future<void> _sellProduct(ProductOperationsModel operation, double sellQuantity) async {
    if (sellQuantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Geçerli bir satış miktarı girin.')),
      );
      return;
    }

    if (sellQuantity > operation.quantity) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Satış miktarı mevcut miktardan fazla olamaz.')),
      );
      return;
    }

    // Yeni miktarı hesapla
    double newQuantity = operation.quantity - sellQuantity;

    // Veritabanında güncelle
    await MongoDatabase.updateProductQuantity(operation.id, newQuantity);

    // Ekranı güncelle
    setState(() {
      _productOperations = _fetchProductOperations(); // Listeyi günceller
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Satış işlemi başarıyla gerçekleşti. Kalan miktar: $newQuantity kg')),
    );
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
                          Text('Mevcut Miktar: ${operation.quantity} kg'),
                          Text('Randıman: ${operation.quality} %'),
                          Text('Tarih: ${operation.createdAt.toLocal()}'),
                          Text('Kayıt Oluşturan: ${operation.createdId}'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: const Icon(Icons.sell),
                        onPressed: () {
                          _showSellDialog(context, operation);
                        },
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

  void _showSellDialog(BuildContext context, ProductOperationsModel operation) {
    final TextEditingController quantityController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Satış Yap - ${operation.operationType}'),
        content: TextField(
          controller: quantityController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(labelText: 'Satış miktarını girin (kg)'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('İptal'),
          ),
          TextButton(
            onPressed: () {
              final double sellQuantity = double.tryParse(quantityController.text) ?? 0;
              Navigator.of(context).pop();
              _sellProduct(operation, sellQuantity);
            },
            child: const Text('Satış Yap'),
          ),
        ],
      ),
    );
  }
}
