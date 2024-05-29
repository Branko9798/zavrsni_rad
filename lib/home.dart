import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_model.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_screen.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<String?> categoryFilter = ValueNotifier(null);

  File? image;
  String? selectedCategory;
  final statisticModel = getIt<StatisticsModel>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
            icon: const Icon(
              Icons.filter_alt_rounded,
              color: Colors.white,
              weight: 500,
            ),
          ),
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.show_chart_rounded,
                weight: 700,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(width: 5),
              Text(
                'Budget Buddy',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          backgroundColor: Colors.tealAccent[400],
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              SizedBox(
                height: 75,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.tealAccent[400]),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'FILTERS ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                title: const Text('Incomes'),
                children: [
                  for (var incomeCategory in IncomeCategory.categories)
                    ListTile(
                      title: Text(incomeCategory.name),
                      onTap: () {
                        setState(() {
                          if (selectedCategory == incomeCategory.id) {
                            selectedCategory = null;
                          } else {
                            selectedCategory = incomeCategory.id;
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      tileColor: selectedCategory == incomeCategory.id
                          ? Colors.grey.withOpacity(0.3)
                          : null,
                    ),
                ],
              ),
              ExpansionTile(
                title: const Text('Expenses'),
                children: [
                  for (var expensesCategory in ExpenseCategory.categories)
                    ListTile(
                      title: Text(expensesCategory.name),
                      onTap: () {
                        setState(() {
                          if (selectedCategory == expensesCategory.id) {
                            selectedCategory = null;
                          } else {
                            selectedCategory = expensesCategory.id;
                          }
                        });
                        Navigator.of(context).pop();
                      },
                      tileColor: selectedCategory == expensesCategory.id
                          ? Colors.grey.withOpacity(0.3)
                          : null,
                    ),
                ],
              ),
            ],
          ),
        ),
        body: Column(
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
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Incomes',
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
                            flex: 2,
                            child: StreamBuilder(
                              stream: statisticModel.total(),
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return const SnackBar(
                                      content:
                                          Text('Oops, something went wrong'));
                                } else {
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
                                }
                              },
                            ),
                          ),
                          const VerticalDivider(
                            indent: 0,
                            color: Colors.white,
                          ),
                          const Expanded(
                              flex: 1,
                              child: Text(
                                'Expenses',
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
            const SizedBox(height: 7),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: StreamBuilder(
                      stream: selectedCategory == null
                          ? getIt<IncomeModel>().allIncomesStream
                          : getIt<IncomeModel>()
                              .filteredIncomes([selectedCategory!]),
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
                                                      title: const Text("Edit"),
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
                                                      title:
                                                          const Text("Remove"),
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
                                                textAlign: TextAlign.center,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                '+${income.incomeValue} €',
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
                                                    income.category!.icon)),
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
                      stream: selectedCategory == null
                          ? getIt<ExpensesModel>().allExpensesStream
                          : getIt<ExpensesModel>()
                              .filteredExpenses([selectedCategory!]),
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
                                  color: Colors.redAccent[100],
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
            ),
          ],
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.tealAccent[400],
          foregroundColor: Colors.white,
          elevation: 3,
          spacing: 10,
          buttonSize: const Size.fromRadius(32),
          overlayOpacity: 0.0,
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
              child: const Icon(
                Icons.money_off,
                size: 35,
              ),
              label: 'Expenses',
              elevation: 5,
              onTap: () {
                _showExpenseScreen(context);
              },
            ),
            SpeedDialChild(
              child: const Icon(
                Icons.attach_money_outlined,
                size: 35,
              ),
              label: 'Incomes',
              elevation: 5,
              onTap: () {
                _showIncomeScreen(context);
              },
            ),
          ],
        ));
  }

  void _showIncomeScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return IncomeScreen();
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
}
