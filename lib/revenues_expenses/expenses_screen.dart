import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses.dart';

class ExpensesScreen extends StatelessWidget {
  ExpensesScreen({super.key});

  final expense = TextEditingController();
  final expenseModel = getIt<ExpensesModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Expenses',
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[400],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Insert your expenses:'),
              ],
            ),
            const SizedBox(height: 15),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: expense,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Field can not be empty';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Expense',
                suffixIcon: IconButton(
                  onPressed: expense.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: () {
                    final expenses =
                        Expense(const Uuid().v4(), double.parse(expense.text));

                    expenseModel.addExpense(expenses);

                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.tealAccent[400],
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
