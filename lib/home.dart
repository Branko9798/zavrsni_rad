import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/revenues_expenses/revnues/revenues_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

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
        body: StreamBuilder(
          stream: getIt<ExpensesModel>().allExpensesStream,
          builder: (context, snapshot) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].expense.toString());
              },
              itemCount: snapshot.data?.length ?? 0,
            );
          },
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
              label: 'Revenues',
              elevation: 5,
              onTap: () {
                _showRevenueScreen(context);
              },
            ),
          ],
        )
        
        );
  }

  void _showRevenueScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return RevenuesScreen();
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
