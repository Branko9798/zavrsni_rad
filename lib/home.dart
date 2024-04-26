import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_screen.dart';

class Home extends StatelessWidget {
  Home({super.key});

  ValueNotifier<String?> categoryFilter = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'HOME',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.tealAccent[400],
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: getIt<ExpensesModel>().allExpensesStream,
                builder: (context, snapshot) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      // TODO: Handle other states of snapshot
                      final expense = snapshot.data![index];
                      return Card(
                        color: Colors.red[100],
                        child: InkWell(
                          onLongPress: () {},
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      expense.expenseNote,
                                      style: const TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '-${expense.expenseValue} €',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 13,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  child: Center(
                                      child: FaIcon(expense.category!.icon)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: snapshot.data?.length ?? 0,
                  );
                },
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

  void _showExpenseScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return ExpensesScreen();
        },
      ),
    );
  }
}
