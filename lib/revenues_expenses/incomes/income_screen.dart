import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_model.dart';

class IncomeScreen extends StatefulWidget {
  IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final income = TextEditingController();

  final incomeModel = getIt<IncomeModel>();

  int? selectedIndex;

  String? selectedIconId;
  String? selectedIconName;

  double boxHeight = 0;
  final note = TextEditingController();
  final incomeValue = TextEditingController();
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
          'Incomes',
          style: TextStyle(color: Colors.white),
        ),
        leading: const BackButton(
          color: Colors.white,
        ),
        centerTitle: true,
        backgroundColor: Colors.tealAccent[400],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 35,
                  width: 90,
                  decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      _showExpenseScreen(context);
                    },
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
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {},
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
              itemCount: IncomeCategory.categories.length,
              padding: const EdgeInsets.symmetric(vertical: 20),
              itemBuilder: (context, index) {
                final incomeCategory = IncomeCategory.categories[index];

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
                                  selectedIconId = incomeCategory.id;
                                  selectedIconName = incomeCategory.name;
                                }
                                changeAnimatedContainer();
                              });
                            },
                            icon: FaIcon(
                              incomeCategory.icon,
                            ))),
                    Text(incomeCategory.name),
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
                          onFieldSubmitted: (value) {
                            saveButton();
                            Navigator.of(context).pop();
                          },
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
                          controller: incomeValue,
                          focusNode: valueFocusNode,
                          onFieldSubmitted: (value) {
                            saveButton();
                            Navigator.of(context).pop();
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Price: ',
                            suffixIcon: IconButton(
                              onPressed: incomeValue.clear,
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

  void _showExpenseScreen(BuildContext context) {
  Navigator.of(context).pushReplacement(
    PageRouteBuilder<void>(
      pageBuilder: (context, animation1, animation2) {
        return ExpensesScreen();
      },
      transitionDuration: Duration.zero, 
    ),
  );
}

  void saveButton() {
    final incomeDb = Income(const Uuid().v4(), note.text,
        double.parse(incomeValue.text), selectedIconId.toString());
    incomeModel.addIncome(incomeDb);
  }
}
