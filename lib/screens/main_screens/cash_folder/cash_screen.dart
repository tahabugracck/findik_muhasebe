// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CashScreen extends StatefulWidget {
  const CashScreen({super.key});

  @override
  _CashScreenState createState() => _CashScreenState();
}

class _CashScreenState extends State<CashScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _showPreliminaryAccounting = false;

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

  void _togglePreliminaryAccounting() {
    setState(() {
      _showPreliminaryAccounting = !_showPreliminaryAccounting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kasa İşlemleri'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Kart'),
            Tab(text: 'Nakit'),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                CashTab(tabType: 'Kart'),
                CashTab(tabType: 'Nakit'),
              ],
            ),
          ),
          // '+' butonu ekle
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _togglePreliminaryAccounting,
              child: const Text('Ön Muhasebe Ekle'),
            ),
          ),
          // Preliminary Accounting Card
          if (_showPreliminaryAccounting)
            const Card(
              margin: EdgeInsets.all(16.0),
              child: PreliminaryAccountingScreen(),
            ),
        ],
      ),
    );
  }
}

class CashTab extends StatelessWidget {
  final String tabType;

  const CashTab({super.key, required this.tabType});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Gelir/Gider ekleme fonksiyonu
          },
          child: Text('$tabType Gelir/Gider Ekle'),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: 5, // Örnek veri sayısı
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text('$tabType İşlem ${index + 1}'),
                  subtitle: Text('Tutar: ${index * 50} TL'), // Örnek veri
                  trailing: const Icon(Icons.arrow_forward),
                  onTap: () {
                    // İşlem detaylarına gitmek için fonksiyon
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

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
    return Padding(
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
    );
  }
}
