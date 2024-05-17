import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  DateTime date = DateTime.now();

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
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                var selectedDate = await showDatePicker(
                  context: context,
                  initialDate: date,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(3000),
                );
                setState(() {
                  if (selectedDate != null) {
                    date = selectedDate;
                  }
                });
              },
              icon: const Icon(
                Icons.date_range_outlined,
                color: Colors.white,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: Container(
                      decoration: BoxDecoration(
                        border:
                            const Border(top: BorderSide(color: Colors.white)),
                        color: Colors.tealAccent[400],
                      ),
                      child: Row(
                        children: <Widget>[
                          const Expanded(
                            flex: 2,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '',
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const VerticalDivider(
                            indent: 0,
                            color: Colors.white,
                          ),
                          Expanded(
                            flex: 3,
                            child: StreamBuilder(
                                stream: statisticsModel.total(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const SizedBox();
                                  }
                                  if (snapshot.hasError) {
                                    return const SnackBar(
                                        content:
                                            Text('Oops, something went wrong'));
                                  }

                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "BALANCE: ${snapshot.data}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          const VerticalDivider(
                            indent: 0,
                            color: Colors.white,
                          ),
                          const Expanded(
                              flex: 2,
                              child: Text(
                                '',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Container(
              height: 300,
              width: 400,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                border: Border.all(color: Colors.black, width: 1.0),
              ),
              child: StreamBuilder(
                stream: statisticsModel.expensesByCategory(date),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const SnackBar(
                        content: Text('Oops, something went wrong'));
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
                stream: statisticsModel.incomesByCategory(date),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                        ),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return const SnackBar(
                        content: Text('Oops, something went wrong'));
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: statisticsModel.incomeLineChartPoints(date),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const SnackBar(
                          content: Text('Oops, something went wrong'));
                    } else {
                      return LineChart(snapshot.requireData);
                    }
                  },
                ),
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
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: StreamBuilder(
                  stream: statisticsModel.expenseLineChartPoints(date),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasError) {
                      return const SnackBar(
                          content: Text('Oops, something went wrong'));
                    } else {
                      return LineChart(snapshot.requireData);
                    }
                  },
                ),
              ),
            ),
          ],
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
