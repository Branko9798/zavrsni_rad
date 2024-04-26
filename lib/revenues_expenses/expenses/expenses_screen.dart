import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_screen.dart';

class ExpensesScreen extends StatefulWidget {
  ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final expenseModel = getIt<ExpensesModel>();

  int? selectedIndex;

  String? selectedIconId;
  String? selectedIconName;

  double boxHeight = 0;
  final note = TextEditingController();
  final expensesValue = TextEditingController();
  final valueFocusNode = FocusNode();

  void changeAnimatedContainer() {
    setState(() {
      if (selectedIndex == null) {
        boxHeight = 0;
      } else {
        boxHeight = 200;
      }
    });
  }

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
        actions: [
          TextButton(
              onPressed: () {
                final expenseDb = Expense(
                  const Uuid().v4(),
                  note.text,
                  double.parse(expensesValue.text),
                  selectedIconId.toString(),
                );
                expenseModel.addExpense(expenseDb);
                Navigator.pop(context);
              },
              child: const Text('SAVE'))
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Expenses',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  height: 35,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      _showRevenueScreen(context);
                    },
                    child: const Text(
                      'Income',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: ExpenseCategory.categories.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                final expenseCategory = ExpenseCategory.categories[index];

                return Column(
                  children: [
                    Container(
                        height: 55,
                        width: 55,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: selectedIndex == index
                                ? Colors.tealAccent[200]
                                : Colors.grey[300]),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                if (selectedIndex == index) {
                                  selectedIndex = null;
                                  selectedIconId = null;
                                  selectedIconName = null;
                                } else {
                                  selectedIndex = index;
                                  selectedIconId = expenseCategory.id;
                                  selectedIconName = expenseCategory.name;
                                }
                                changeAnimatedContainer();
                              });
                            },
                            icon: FaIcon(
                              expenseCategory.icon,
                            ))),
                    Text(expenseCategory.name),
                  ],
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            ),
          ),
          AnimatedContainer(
            duration: boxHeight == 0
                ? const Duration(milliseconds: 500)
                : const Duration(milliseconds: 250),
            color: Colors.grey[100],
            height: boxHeight,
            curve: boxHeight == 0 ? Curves.easeInBack : Curves.easeIn,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        TextFormField(
                          controller: note,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Note: ',
                            suffixIcon: IconButton(
                              onPressed: note.clear,
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: expensesValue,
                          focusNode: valueFocusNode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Price: ',
                            suffixIcon: IconButton(
                              onPressed: expensesValue.clear,
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showRevenueScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return IncomeScreen();
        },
      ),
    );
  }
}
