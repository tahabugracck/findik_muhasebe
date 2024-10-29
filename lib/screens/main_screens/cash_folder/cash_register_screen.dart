/*
// ignore_for_file: library_private_types_in_public_api

import 'package:findik_muhasebe/screens/main_screens/cash_folder/add_movement_screen.dart';
import 'package:findik_muhasebe/services/mongodb.dart';
import 'package:findik_muhasebe/widgets/theme_notifier.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';


class CashRegisterScreen extends StatefulWidget {
  const CashRegisterScreen({super.key});

  @override
  _CashRegisterScreenState createState() => _CashRegisterScreenState();
}

class _CashRegisterScreenState extends State<CashRegisterScreen> {
  List<Map<String, dynamic>> cashIncomeMovements = [];
  List<Map<String, dynamic>> cashExpenseMovements = [];
  List<Map<String, dynamic>> cardIncomeMovements = [];
  List<Map<String, dynamic>> cardExpenseMovements = [];
  bool isLoading = false;
  String errorMessage = '';
  double totalIncome = 0.0;
  double totalExpense = 0.0;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoading = true;
      errorMessage = '';
    });
    try {
      cashIncomeMovements = await MongoDatabase.getCashIncomeMovements();
      cashExpenseMovements = await MongoDatabase.getCashExpenseMovements();
      cardIncomeMovements = await MongoDatabase.getCardsIncomeMovements();
      cardExpenseMovements = await MongoDatabase.getCardsExpenseMovements();

      totalIncome = _calculateTotal(cashIncomeMovements) +
          _calculateTotal(cardIncomeMovements);
      totalExpense = _calculateTotal(cashExpenseMovements) +
          _calculateTotal(cardExpenseMovements);
    } catch (e) {
      if (kDebugMode) {
        print('Veri yükleme hatası: $e');
      }
      setState(() {
        errorMessage = 'Veriler yüklenirken bir hata oluştu: ${e.toString()}';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  double _calculateTotal(List<Map<String, dynamic>> movements) {
    return movements.fold(0.0, (sum, movement) {
      final amount = (movement["amount"] is int)
          ? (movement["amount"] as int).toDouble()
          : double.tryParse(movement["amount"].toString()) ?? 0.0;
      return sum + amount;
    });
  }

  void _showAddMovementDialog() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: AddMovementScreen(onSubmit: (movement) async {
            String userId = '66aa2e456d72b0822ad566e8'; // Örnek kullanıcı ID'si

            try {
              DateTime transactionDate;
              if (movement['transactionDate'] != null) {
                try {
                  transactionDate = DateFormat('dd/MM/yyyy')
                      .parse(movement['transactionDate']);
                } catch (e) {
                  if (kDebugMode) {
                    print('Tarih formatı hatalı, düzeltilemedi: $e');
                  }
                  transactionDate = DateTime.now();
                }
              } else {
                transactionDate = DateTime.now();
              }

              if (kDebugMode) {
                print('İşlem Detayları: ${movement.toString()}');
              }

              if (movement['type'] == 'Kart') {
                await MongoDatabase.addCardMovement(userId, {
                  'to_from': movement['to_from'],
                  'amount':
                      double.tryParse(movement['amount'].toString()) ?? 0.0,
                  'transactionDate': transactionDate.toIso8601String(),
                  'description': movement['description'],
                  'incoming': movement['transactionType'] == 'Gelir',
                });
              } else if (movement['type'] == 'Nakit') {
                await MongoDatabase.addCashMovement(userId, {
                  'to_from': movement['to_from'],
                  'amount':
                      double.tryParse(movement['amount'].toString()) ?? 0.0,
                  'transactionDate': transactionDate.toIso8601String(),
                  'description': movement['description'],
                  'incoming': movement['transactionType'] == 'Gelir',
                });
              }
              await loadData();
            } catch (e) {
              if (kDebugMode) {
                print('İşlem eklenirken hata oluştu: $e');
              }
            }
            // ignore: use_build_context_synchronously
            Navigator.pop(context);
          }),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeNotifier>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Hesap Hareketleri'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Kart'),
              Tab(text: 'Nakit'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: loadData,
              tooltip: 'Yenile',
            ),
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _showAddMovementDialog,
              tooltip: 'Yeni Hareket Ekle',
            ),
          ],
        ),
        body: TabBarView(
          children: [
            _buildCardAndCashView('Kart'),
            _buildCardAndCashView('Nakit'),
          ],
        ),
      ),
    );
  }

  Widget _buildCardAndCashView(String type) {
    final List<Map<String, dynamic>> incomeMovements =
        type == 'Nakit' ? cashIncomeMovements : cardIncomeMovements;
    final List<Map<String, dynamic>> expenseMovements =
        type == 'Nakit' ? cashExpenseMovements : cardExpenseMovements;

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(text: 'Gelir'),
                Tab(text: 'Gider'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _buildMovementList(incomeMovements, '$type Gelirler',
                      Colors.green, true, type),
                  _buildMovementList(expenseMovements, '$type Giderler',
                      Colors.red, false, type),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovementList(List<Map<String, dynamic>> movements, String title,
      Color amountColor, bool isIncome, String type) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (errorMessage.isNotEmpty) {
      return Center(
          child: Text(errorMessage, style: const TextStyle(color: Colors.red)));
    }
    if (movements.isEmpty) {
      return const Center(
          child: Text('Veri bulunamadı',
              style: TextStyle(fontSize: 16, color: Colors.grey)));
    }

    double total = movements.fold(0.0, (sum, movement) {
      final amount = (movement["amount"] is int)
          ? (movement["amount"] as int).toDouble()
          : double.tryParse(movement["amount"].toString()) ?? 0.0;
      return sum + amount;
    });

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: movements.length,
            itemBuilder: (context, index) {
              final movement = movements[index];
              final amount = (movement["amount"] is int)
                  ? (movement["amount"] as int).toDouble()
                  : double.tryParse(movement["amount"].toString()) ?? 0.0;
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                elevation: 4,
                child: ListTile(
                  title: Text(movement["to_from"] ?? ''),
                  subtitle: Text(DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(movement["transactionDate"]))),
                  trailing: Text(
                    '${amountColor == Colors.green ? '+' : '-'} ${amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: amountColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Toplam: ${amountColor == Colors.green ? '+' : '-'} ${total.toStringAsFixed(2)}',
            style: TextStyle(
              color: amountColor,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}
*/