// ignore_for_file: library_private_types_in_public_api

import 'package:bson/bson.dart';
import 'package:findik_muhasebe/models/deposit.dart';
import 'package:findik_muhasebe/screens/main_screens/deposit_folder/deposit_detail_screen.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  List<DepositModel> _emanetler = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEmanetler();
  }

  Future<void> _fetchEmanetler() async {
    List<Map<String, dynamic>> emanetler = await MongoDatabase.fetchAllDeposit();
    setState(() {
      _emanetler = emanetler.map((e) => DepositModel.fromJson(e)).toList();
      _isLoading = false;
    });
  }

  // Emanet ekleme fonksiyonu
  Future<void> _addEmanet() async {
    final newDeposit = await showDialog<DepositModel>(
      context: context,
      builder: (BuildContext context) {
        String itemName = '';
        double quantity = 1.0;
        String description = '';
        bool status = true;

        return AlertDialog(
          title: const Text('Yeni Emanet Ekle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Emanet Adı'),
                onChanged: (value) => itemName = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Miktar'),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = double.tryParse(value) ?? 1.0,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Açıklama'),
                onChanged: (value) => description = value,
              ),
              CheckboxListTile(
                title: const Text('Aktif'),
                value: status,
                onChanged: (value) {
                  setState(() {
                    status = value ?? true;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final deposit = DepositModel(
                  id: ObjectId(),
                  customerId: ObjectId(), // Gerekli customerId'yi uygun bir değerle değiştirin
                  itemName: itemName,
                  quantity: quantity,
                  transactionDate: DateTime.now(),
                  status: status,
                  description: description,
                );
                Navigator.of(context).pop(deposit);
              },
              child: const Text('Ekle'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );

    if (newDeposit != null) {
      await MongoDatabase.addDeposit(newDeposit);
      _fetchEmanetler(); // Emanetler güncellendi
    }
  }

  // Emanet silme fonksiyonu
  Future<void> _deleteEmanet(ObjectId id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Emaneti Sil'),
          content: const Text('Bu emanet silinsin mi?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Evet'),
            ),
          ],
        );
      },
    );

    if (confirmed == true) {
      await MongoDatabase.deleteDeposit(id);
      _fetchEmanetler(); // Emanetler güncellendi
    }
  }

  // Emanet güncelleme fonksiyonu
  Future<void> _updateEmanet(DepositModel deposit) async {
    final updatedDeposit = await showDialog<DepositModel>(
      context: context,
      builder: (BuildContext context) {
        String itemName = deposit.itemName;
        double quantity = deposit.quantity;
        String description = deposit.description;
        bool status = deposit.status;

        return AlertDialog(
          title: const Text('Emaneti Güncelle'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Emanet Adı'),
                onChanged: (value) => itemName = value,
                controller: TextEditingController(text: itemName),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Miktar'),
                keyboardType: TextInputType.number,
                onChanged: (value) => quantity = double.tryParse(value) ?? quantity,
                controller: TextEditingController(text: quantity.toString()),
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Açıklama'),
                onChanged: (value) => description = value,
                controller: TextEditingController(text: description),
              ),
              CheckboxListTile(
                title: const Text('Aktif'),
                value: status,
                onChanged: (value) {
                  setState(() {
                    status = value ?? status;
                  });
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final depositToUpdate = deposit.copyWith(
                  itemName: itemName,
                  quantity: quantity,
                  description: description,
                  status: status,
                );
                Navigator.of(context).pop(depositToUpdate);
              },
              child: const Text('Güncelle'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('İptal'),
            ),
          ],
        );
      },
    );

    if (updatedDeposit != null) {
      await MongoDatabase.updateDeposit(updatedDeposit);
      _fetchEmanetler(); // Emanetler güncellendi
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Emanetler'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addEmanet, // Emanet ekle
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _emanetler.isEmpty
              ? const Center(child: Text('Hiç emanet bulunamadı.'))
              : ListView.builder(
                  itemCount: _emanetler.length,
                  itemBuilder: (context, index) {
                    final emanet = _emanetler[index];
                    return ListTile(
                      title: Text(emanet.itemName),
                      subtitle: Text('Miktar: ${emanet.quantity}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => _updateEmanet(emanet), // Emanet güncelle
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteEmanet(emanet.id), // Emanet sil
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DepositDetailScreen(deposit: emanet),
                          ),
                        );
                      },
                    );
                  },
                ),
    );
  }
}
