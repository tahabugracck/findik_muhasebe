// ignore_for_file: prefer_const_constructors

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapor Ekranı'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Fındık Satış Raporu',
              style: TextStyle(fontSize: 20),
            ),
            Expanded(
              child: BarChart(
                BarChartData(
                  barGroups: _createSampleData(),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                    bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Örnek veri oluşturan fonksiyon
  List<BarChartGroupData> _createSampleData() {
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(toY: 50, color: Colors.blue)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(toY: 100, color: Colors.blue)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(toY: 75, color: Colors.blue)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(toY: 120, color: Colors.blue)]),
    ];
  }
}
