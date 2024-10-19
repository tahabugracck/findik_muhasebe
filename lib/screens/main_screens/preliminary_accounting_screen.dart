// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class PreliminaryAccountingScreen extends StatefulWidget {
  const PreliminaryAccountingScreen({super.key});

  @override
  _PreliminaryAccountingScreenState createState() => _PreliminaryAccountingScreenState();
}

class _PreliminaryAccountingScreenState extends State<PreliminaryAccountingScreen> {
  List<String> incomeList = [];
  List<String> expenseList = [];
  String income = '';
  String expense = '';

  void addIncome() {
    if (income.isNotEmpty) {
      setState(() {
        incomeList.add(income);
        income = '';
      });
    }
  }

  void addExpense() {
    if (expense.isNotEmpty) {
      setState(() {
        expenseList.add(expense);
        expense = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ön Muhasebe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Gelir Ekle',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              onChanged: (value) {
                income = value;
              },
              decoration: const InputDecoration(labelText: 'Gelir Tutarı'),
            ),
            ElevatedButton(
              onPressed: addIncome,
              child: const Text('Gelir Ekle'),
            ),
            const SizedBox(height: 20),
            const Text(
              'Gider Ekle',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              onChanged: (value) {
                expense = value;
              },
              decoration: const InputDecoration(labelText: 'Gider Tutarı'),
            ),
            ElevatedButton(
              onPressed: addExpense,
              child: const Text('Gider Ekle'),
            ),
            const SizedBox(height: 20),
            Text(
              'Toplam Gelir: ${incomeList.length}',
              style: const TextStyle(fontSize: 16),
            ),
            Text(
              'Toplam Gider: ${expenseList.length}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const Text('Gelirler:', style: TextStyle(fontSize: 18)),
                  ...incomeList.map((e) => ListTile(title: Text(e))),
                  const SizedBox(height: 20),
                  const Text('Giderler:', style: TextStyle(fontSize: 18)),
                  ...expenseList.map((e) => ListTile(title: Text(e))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
