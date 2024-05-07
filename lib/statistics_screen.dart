import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_model.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final incomeModel = getIt<IncomeModel>();



    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[400],
      ),
      body: Column(
        children: [
          Container(
            height: 500,
            width: 500,
            color: Colors.amber,
            child: PieChart(PieChartData()),
          )
        ],
      ),
    );
  }
}
