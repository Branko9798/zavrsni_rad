import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final statisticsModel = getIt<StatisticsModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Statistics',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[400],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 500,
              width: 500,
              child: StreamBuilder(
                stream: statisticsModel.expensesByCategory(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  var data = snapshot.requireData;

                  data = data.copyWith(
                    centerSpaceColor: Colors.white,
                    borderData: FlBorderData(show: false),
                    sectionsSpace: 0,
                    centerSpaceRadius: 100,
                  );
                  final double totalExpenses = snapshot.data!.sumValue;
                  return Stack(
                    children: [
                      PieChart(data),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            "Expenses: ${totalExpenses.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 500,
              width: 500,
              child: StreamBuilder(
                stream: statisticsModel.incomesByCategory(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }
                  var data = snapshot.requireData;

                  data = data.copyWith(
                      centerSpaceColor: Colors.white,
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 0,
                      centerSpaceRadius: 100);
                  final double totalIncomes = snapshot.data!.sumValue;
                  return Stack(
                    children: [
                      PieChart(data),
                      Positioned.fill(
                        child: Center(
                          child: Text(
                            "Incomes: ${totalIncomes.toStringAsFixed(2)}",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
