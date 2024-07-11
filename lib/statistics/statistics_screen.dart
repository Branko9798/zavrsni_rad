import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/home.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_model.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_screen.dart';
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

    return DefaultTabController(
      length: 5,
      child: Scaffold(
          appBar: AppBar(
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.area_chart_rounded,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  'Statistics',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            centerTitle: true,
            backgroundColor: Colors.tealAccent[400],
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
                ),
              ),
            ],
            bottom: const TabBar(tabs: [
              Tab(
                icon: (FaIcon(
                  FontAwesomeIcons.moneyBill1Wave,
                  color: Colors.white,
                  size: 20,
                )),
                child: Row(
                  children: [
                    Text(
                      "Inc. ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.pie_chart_outline,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Tab(
                icon: (FaIcon(
                  FontAwesomeIcons.moneyBillTrendUp,
                  color: Colors.white,
                  size: 20,
                )),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Inc. ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.area_chart_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Tab(
                icon: (FaIcon(
                  FontAwesomeIcons.dollarSign,
                  color: Colors.white,
                  size: 20,
                )),
                child: Row(
                  children: [
                    Text(
                      " TOTAL",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                icon: (FaIcon(
                  FontAwesomeIcons.circleDollarToSlot,
                  color: Colors.white,
                  size: 20,
                )),
                child: Row(
                  children: [
                    Text(
                      "Exp. ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.pie_chart_outline,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
              Tab(
                icon: (FaIcon(
                  FontAwesomeIcons.moneyCheckDollar,
                  color: Colors.white,
                  size: 20,
                )),
                child: Row(
                  children: [
                    Text(
                      "Exp. ",
                      style: TextStyle(color: Colors.white),
                    ),
                    Icon(
                      Icons.area_chart_outlined,
                      color: Colors.white,
                      size: 12,
                    ),
                  ],
                ),
              ),
            ]),
          ),
          body: TabBarView(
            children: [
              Column(
                children: [
                  const ListTile(
                    title: Text(
                      "TOTAL INCOMES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text("Pie Chart"),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                      stream: statisticsModel.incomesByCategory(date),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                        var data = snapshot.data;

                        if (data == null) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 48.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  "No data.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
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
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: getIt<IncomeModel>().allIncomesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SnackBar(
                              content: Text('Oops, something went wrong'));
                        }

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final sortedIncomes =
                                List<Income>.from(snapshot.data!);
                            sortedIncomes
                                .sort((a, b) => a.date.compareTo(b.date));

                            final income = sortedIncomes[index];

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${income.date.day}/${income.date.month}/${income.date.year}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Card(
                                    color: Colors.tealAccent[200],
                                    child: InkWell(
                                      onLongPress: () {},
                                      child: Row(
                                        children: [
                                          PopupMenuButton(
                                              itemBuilder: ((context) => [
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        leading: const Icon(
                                                            Icons.edit),
                                                        title:
                                                            const Text("Edit"),
                                                        onTap: () {
                                                          _showIncomesScreen(
                                                              context,
                                                              incomeToEdit:
                                                                  income);
                                                        },
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        leading: const Icon(
                                                            Icons.delete),
                                                        title: const Text(
                                                            "Remove"),
                                                        onTap: () {
                                                          IncomeModel()
                                                              .removeIncome(
                                                                  income);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    )
                                                  ])),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  income.incomeNote,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '+${income.incomeValue} €',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Center(
                                                  child: FaIcon(
                                                      income.category!.icon)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const ListTile(
                    title: Text(
                      "INCOMES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text(
                      "Line Chart",
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder(
                        stream: statisticsModel.incomeLineChartPoints(date),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                          if (snapshot.data == null) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 48.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    "No data.",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          if (snapshot.hasError) {
                            return const SnackBar(
                              content: Text('Oops, something went wrong'),
                            );
                          } else {
                            return LineChart(snapshot.data!);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: getIt<IncomeModel>().allIncomesStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return const SnackBar(
                              content: Text('Oops, something went wrong'));
                        }

                        return ListView.builder(
                          itemBuilder: (context, index) {
                            final sortedIncomes =
                                List<Income>.from(snapshot.data!);
                            sortedIncomes
                                .sort((a, b) => a.date.compareTo(b.date));

                            final income = sortedIncomes[index];

                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${income.date.day}/${income.date.month}/${income.date.year}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: Card(
                                    color: Colors.tealAccent[200],
                                    child: InkWell(
                                      onLongPress: () {},
                                      child: Row(
                                        children: [
                                          PopupMenuButton(
                                              itemBuilder: ((context) => [
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        leading: const Icon(
                                                            Icons.edit),
                                                        title:
                                                            const Text("Edit"),
                                                        onTap: () {
                                                          _showIncomesScreen(
                                                              context,
                                                              incomeToEdit:
                                                                  income);
                                                        },
                                                      ),
                                                    ),
                                                    PopupMenuItem(
                                                      child: ListTile(
                                                        leading: const Icon(
                                                            Icons.delete),
                                                        title: const Text(
                                                            "Remove"),
                                                        onTap: () {
                                                          IncomeModel()
                                                              .removeIncome(
                                                                  income);
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                      ),
                                                    )
                                                  ])),
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  income.incomeNote,
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '+${income.incomeValue} €',
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 13,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                              ),
                                              child: Center(
                                                  child: FaIcon(
                                                      income.category!.icon)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      },
                    ),
                  )
                ],
              ),
              Column(
                children: [
                  ListTile(
                    title: const Text(
                      "TOTAL ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StreamBuilder<Map<String, double>>(
                          stream: getIt<StatisticsModel>()
                              .averageValuesForCurrentMonth(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Oops, something went wrong");
                            } else if (snapshot.hasData) {
                              final averageValues = snapshot.data!;
                              final averageIncome =
                                  averageValues['averageIncome'];
                              final averageExpense =
                                  averageValues['averageExpense'];
                              return Text(
                                'Average Income: \$${averageIncome?.toStringAsFixed(2)}\n'
                                'Average Expense: \$${averageExpense?.toStringAsFixed(2)}',
                              );
                            } else {
                              return const Text("");
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                      stream: statisticsModel.incomeExpensePieChart(date),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return const Text('Oops, something went wrong');
                        }
                        var data = snapshot.data;

                        if (data == null) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 48.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  "No data.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        data = data.copyWith(
                            centerSpaceColor: Colors.white,
                            borderData: FlBorderData(show: false),
                            sectionsSpace: 0,
                            centerSpaceRadius: 70,
                            sections: data.sections
                                .map((e) => e.copyWith(showTitle: true))
                                .toList());

                        return Stack(
                          children: [
                            PieChart(data),
                            Positioned.fill(
                              child: Center(
                                child: StreamBuilder(
                                  stream: getIt<StatisticsModel>().total(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasError) {
                                      return const SnackBar(
                                          content: Text(
                                              'Oops, something went wrong'));
                                    } else {
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "TOTAL: ${snapshot.data}",
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text("Incomes")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: 16,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text("Expenses")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: StreamBuilder(
                            stream: getIt<IncomeModel>().allIncomesStream,
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                return const SnackBar(
                                    content:
                                        Text('Oops, something went wrong'));
                              }

                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  final sortedIncomes =
                                      List<Income>.from(snapshot.data!);
                                  sortedIncomes
                                      .sort((a, b) => a.date.compareTo(b.date));

                                  final income = sortedIncomes[index];

                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.calendar_today,
                                                color: Colors.grey, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${income.date.day}/${income.date.month}/${income.date.year}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        color: Colors.tealAccent[200],
                                        child: InkWell(
                                          onLongPress: () {},
                                          child: Row(
                                            children: [
                                              PopupMenuButton(
                                                  itemBuilder: ((context) => [
                                                        PopupMenuItem(
                                                          child: ListTile(
                                                            leading: const Icon(
                                                                Icons.edit),
                                                            title: const Text(
                                                                "Edit"),
                                                            onTap: () {
                                                              _showIncomesScreen(
                                                                  context,
                                                                  incomeToEdit:
                                                                      income);
                                                            },
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          child: ListTile(
                                                            leading: const Icon(
                                                                Icons.delete),
                                                            title: const Text(
                                                                "Remove"),
                                                            onTap: () {
                                                              IncomeModel()
                                                                  .removeIncome(
                                                                      income);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        )
                                                      ])),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      income.incomeNote,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '+${income.incomeValue} €',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Center(
                                                      child: FaIcon(income
                                                          .category!.icon)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data?.length ?? 0,
                              );
                            },
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: getIt<ExpensesModel>().allExpensesStream,
                            builder: (context, snapshot) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  if (snapshot.hasError) {
                                    return const SnackBar(
                                        content:
                                            Text('Oops, something went wrong'));
                                  }
                                  final sortedExpenses =
                                      List<Expense>.from(snapshot.data!);
                                  sortedExpenses
                                      .sort((a, b) => a.date.compareTo(b.date));
                                  final expense = sortedExpenses[index];
                                  return Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            const Icon(Icons.calendar_today,
                                                color: Colors.grey, size: 16),
                                            const SizedBox(width: 4),
                                            Text(
                                              "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                                              style: const TextStyle(
                                                  color: Colors.grey),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Card(
                                        color: Colors.red[100],
                                        child: InkWell(
                                          onLongPress: () {},
                                          child: Row(
                                            children: [
                                              PopupMenuButton(
                                                  itemBuilder: ((context) => [
                                                        PopupMenuItem(
                                                          child: ListTile(
                                                            leading: const Icon(
                                                                Icons.edit),
                                                            title: const Text(
                                                                "Edit"),
                                                            onTap: () {
                                                              _showExpenseScreen(
                                                                  context,
                                                                  expenseToEdit:
                                                                      expense);
                                                            },
                                                          ),
                                                        ),
                                                        PopupMenuItem(
                                                          child: ListTile(
                                                            leading: const Icon(
                                                                Icons.delete),
                                                            title: const Text(
                                                                "Remove"),
                                                            onTap: () {
                                                              ExpensesModel()
                                                                  .removeExpense(
                                                                      expense);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                          ),
                                                        )
                                                      ])),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      expense.expenseNote,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    const SizedBox(height: 4),
                                                    Text(
                                                      '-${expense.expenseValue} €',
                                                      style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 13,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(15),
                                                      bottomRight:
                                                          Radius.circular(15),
                                                    ),
                                                  ),
                                                  child: Center(
                                                      child: FaIcon(expense
                                                          .category!.icon)),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 7),
                                    ],
                                  );
                                },
                                itemCount: snapshot.data?.length ?? 0,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const ListTile(
                    title: Text(
                      "TOTAL EXPENSES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text("Pie Chart"),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: StreamBuilder(
                      stream: statisticsModel.expensesByCategory(date),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return const Text('Oops, something went wrong');
                        }
                        var data = snapshot.data;

                        if (data == null) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.info_outline,
                                  size: 48.0,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  "No data.",
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

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
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: getIt<ExpensesModel>().allExpensesStream,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            if (snapshot.hasError) {
                              return const SnackBar(
                                  content: Text('Oops, something went wrong'));
                            }
                            final sortedExpenses =
                                List<Expense>.from(snapshot.data!);
                            sortedExpenses
                                .sort((a, b) => a.date.compareTo(b.date));
                            final expense = sortedExpenses[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.red[100],
                                  child: InkWell(
                                    onLongPress: () {},
                                    child: Row(
                                      children: [
                                        PopupMenuButton(
                                            itemBuilder: ((context) => [
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.edit),
                                                      title: const Text("Edit"),
                                                      onTap: () {
                                                        _showExpenseScreen(
                                                            context,
                                                            expenseToEdit:
                                                                expense);
                                                      },
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text("Remove"),
                                                      onTap: () {
                                                        ExpensesModel()
                                                            .removeExpense(
                                                                expense);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  )
                                                ])),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                expense.expenseNote,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '-${expense.expenseValue} €',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                                child: FaIcon(
                                                    expense.category!.icon)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const ListTile(
                    title: Text(
                      "EXPENSES",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    subtitle: Text("Line Chart"),
                  ),
                  Container(
                    height: 300,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(color: Colors.black, width: 1.0),
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: StreamBuilder(
                        stream: statisticsModel.expenseLineChartPoints(date),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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

                          if (snapshot.data == null) {
                            return const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 48.0,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(height: 16.0),
                                  Text(
                                    "No data.",
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          } else {
                            return LineChart(snapshot.data!);
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                    child: Divider(
                      indent: 10,
                      endIndent: 10,
                    ),
                  ),
                  Expanded(
                    child: StreamBuilder(
                      stream: getIt<ExpensesModel>().allExpensesStream,
                      builder: (context, snapshot) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            if (snapshot.hasError) {
                              return const SnackBar(
                                  content: Text('Oops, something went wrong'));
                            }
                            final sortedExpenses =
                                List<Expense>.from(snapshot.data!);
                            sortedExpenses
                                .sort((a, b) => a.date.compareTo(b.date));
                            final expense = sortedExpenses[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Icon(Icons.calendar_today,
                                          color: Colors.grey, size: 16),
                                      const SizedBox(width: 4),
                                      Text(
                                        "${expense.date.day}/${expense.date.month}/${expense.date.year}",
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Card(
                                  color: Colors.red[100],
                                  child: InkWell(
                                    onLongPress: () {},
                                    child: Row(
                                      children: [
                                        PopupMenuButton(
                                            itemBuilder: ((context) => [
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.edit),
                                                      title: const Text("Edit"),
                                                      onTap: () {
                                                        _showExpenseScreen(
                                                            context,
                                                            expenseToEdit:
                                                                expense);
                                                      },
                                                    ),
                                                  ),
                                                  PopupMenuItem(
                                                    child: ListTile(
                                                      leading: const Icon(
                                                          Icons.delete),
                                                      title:
                                                          const Text("Remove"),
                                                      onTap: () {
                                                        ExpensesModel()
                                                            .removeExpense(
                                                                expense);
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  )
                                                ])),
                                        Expanded(
                                          flex: 3,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                expense.expenseNote,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '-${expense.expenseValue} €',
                                                style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 13,
                                                ),
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(15),
                                                bottomRight:
                                                    Radius.circular(15),
                                              ),
                                            ),
                                            child: Center(
                                                child: FaIcon(
                                                    expense.category!.icon)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 7),
                              ],
                            );
                          },
                          itemCount: snapshot.data?.length ?? 0,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }

  void _showHomeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return Home();
        },
      ),
    );
  }

  void _showIncomesScreen(
    BuildContext context, {
    Income? incomeToEdit = null,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return IncomeScreen(
            incomeToEdit: incomeToEdit,
          );
        },
      ),
    );
  }

  void _showExpenseScreen(
    BuildContext context, {
    Expense? expenseToEdit = null,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return ExpensesScreen(
            expenseToEdit: expenseToEdit,
          );
        },
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
