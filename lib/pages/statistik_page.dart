import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class StatistikPage extends StatelessWidget {
  const StatistikPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Statistik")),
      body: Center(
        child: SizedBox(
          height: 250,
          child: PieChart(
            PieChartData(sections: [
              PieChartSectionData(value: 40, title: "Teknik", color: Colors.blue),
              PieChartSectionData(value: 30, title: "Ekonomi", color: Colors.red),
              PieChartSectionData(value: 20, title: "Hukum", color: Colors.green),
              PieChartSectionData(value: 10, title: "Lainnya", color: Colors.orange),
            ]),
          ),
        ),
      ),
    );
  }
}
