import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category_model.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category_model.dart';

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
import 'package:zavrsni_rad/user/user_input_screen.dart';
import 'package:zavrsni_rad/user/user_model.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<String?> categoryFilter = ValueNotifier(null);

  File? image;
  String? selectedCategory;
  String? searchQuery; // Search state
  var isSearching = false;
  final statisticModel = getIt<StatisticsModel>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  final userModel = getIt<UserModel>();

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
              Icons.menu,
              color: Colors.white,
              weight: 500,
            ),
          ),
          title: isSearching
              ? SizedBox(
                  height: 40,
                  child: SearchBar(
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    autoFocus: true,
                  ),
                )
              : const Row(
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
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
          backgroundColor: Colors.tealAccent[400],
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  isSearching = !isSearching;
                  if (!isSearching) {
                    searchQuery = null;
                  }
                });
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.tealAccent[400]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StreamBuilder(
                        stream: userModel.getUserStream(),
                        builder: (context, snapshot) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    snapshot.data?.firstName ?? "",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    snapshot.data?.lastName ?? "",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder<List<IncomeCategory>>(
                    stream: getIt<IncomeCategoryModel>().allCategories(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return SizedBox();
                      }
                      return ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          ExpansionTile(
                            title: const Text('Incomes'),
                            children: [
                              for (var incomeCategory in snapshot.requireData)
                                ListTile(
                                  title: Text(incomeCategory.categoryName),
                                  onTap: () {
                                    setState(() {
                                      if (selectedCategory ==
                                          incomeCategory.categoryId) {
                                        selectedCategory = null;
                                      } else {
                                        selectedCategory =
                                            incomeCategory.categoryId;
                                      }
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  tileColor: selectedCategory ==
                                          incomeCategory.categoryId
                                      ? Colors.grey.withOpacity(0.3)
                                      : null,
                                ),
                            ],
                          ),
                        ],
                      );
                    }),
              ),
              Expanded(
                child: StreamBuilder<List<ExpenseCategory>>(
                  stream: getIt<ExpenseCategoryModel>().allCategories(),
                  builder: (context, snapshot) {
                    return ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        ExpansionTile(
                          title: const Text('Incomes'),
                          children: [
                            for (var expenseCategory in snapshot.requireData)
                              ListTile(
                                title: Text(expenseCategory.categoryName),
                                onTap: () {
                                  setState(() {
                                    if (selectedCategory ==
                                        expenseCategory.categoryId) {
                                      selectedCategory = null;
                                    } else {
                                      selectedCategory =
                                          expenseCategory.categoryId;
                                    }
                                  });
                                  Navigator.of(context).pop();
                                },
                                tileColor: selectedCategory ==
                                        expenseCategory.categoryId
                                    ? Colors.grey.withOpacity(0.3)
                                    : null,
                              ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            _showInputUserScreen(context);
                          },
                          child: const Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.user,
                                size: 16,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "User",
                                style: TextStyle(fontSize: 17),
                              ),
                            ],
                          )),
                    ],
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
                      stream: () {
                        switch ((
                          selectedCategory == null,
                          searchQuery == null || searchQuery!.isEmpty
                        )) {
                          case (true, true):
                            return getIt<IncomeModel>().allIncomesStream;
                          case (false, true):
                            return getIt<IncomeModel>()
                                .filteredIncomes([selectedCategory!]);
                          case (true, false):
                            return getIt<IncomeModel>()
                                .searchIncomes(searchQuery!);
                          case (false, false):
                            return getIt<IncomeModel>()
                                .searchIncomes(searchQuery!);
                        }
                      }(),
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
                                          child: Center(
                                            child: StreamBuilder(
                                              stream:
                                                  getIt<IncomeCategoryModel>()
                                                      .getCategoryName(income
                                                          .incomeCategoryId),
                                              builder: ((context, snapshot) {
                                                if (!snapshot.hasData ||
                                                    snapshot.data == null) {
                                                  return SizedBox();
                                                }
                                                return Text(
                                                    snapshot.data ?? '');
                                              }),
                                            ),
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
                      stream: () {
                        switch ((
                          selectedCategory == null,
                          searchQuery == null || searchQuery!.isEmpty
                        )) {
                          case (true, true):
                            return getIt<ExpensesModel>().allExpensesStream;
                          case (false, true):
                            return getIt<ExpensesModel>()
                                .filteredExpenses([selectedCategory!]);
                          case (true, false):
                            return getIt<ExpensesModel>()
                                .searchExpenses(searchQuery!);
                          case (false, false):
                            return getIt<ExpensesModel>()
                                .searchExpenses(searchQuery!);
                        }
                      }(),
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
                                          child: Center(
                                            child: StreamBuilder(
                                              stream:
                                                  getIt<ExpenseCategoryModel>()
                                                      .getCategoryName(expense
                                                          .expensesCategoryId),
                                              builder: ((context, snapshot) {
                                                if (!snapshot.hasData ||
                                                    snapshot.data == null) {
                                                  return SizedBox();
                                                }
                                                return Text(
                                                    snapshot.data ?? '');
                                              }),
                                            ),
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

  void _showInputUserScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return UserInputScreen();
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
