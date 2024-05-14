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
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
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
                        centerSpaceRadius: 70,
                        sections: data.sections
                            .map((e) => e.copyWith(showTitle: true))
                            .toList());
                    final double totalExpenses = snapshot.data!.sumValue;
                    return Stack(
                      children: [
                        PieChart(data),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              "Expenses: ${totalExpenses.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: legendForCharts(data),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
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
                      centerSpaceRadius: 70,
                    );
                    final double totalIncomes = snapshot.data!.sumValue;
                    return Stack(
                      children: [
                        PieChart(data),
                        Positioned.fill(
                          child: Center(
                            child: Text(
                              "Incomes: ${totalIncomes.toStringAsFixed(2)}",
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: legendForCharts(data),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: 300,
                width: 400,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  border: Border.all(color: Colors.black, width: 1.0),
                ),
                child: StreamBuilder(
                  stream: statisticsModel.expenseLineChartPoints(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return LineChart(snapshot.requireData);
                    } else {
                      return const SizedBox();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> legendForCharts(PieChartData data) {
    List<Widget> legendItems = [];

    for (int i = 0; i < data.sections.length; i++) {
      var section = data.sections[i];
      var color = section.color;
      String title;
      if (section is CustomPieChartSectionData) {
        title = section.legendTitle;
      } else {
        title = section.title;
      }
      legendItems.add(Row(
        children: <Widget>[
          Container(
            height: 16,
            width: 16,
            color: color,
          ),
          const SizedBox(width: 5),
          Text(
            title,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ));
    }
    return legendItems;
  }
}
