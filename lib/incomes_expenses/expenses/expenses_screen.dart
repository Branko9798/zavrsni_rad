import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category_model.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category_screen.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_screen.dart';
import 'package:intl/intl.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key, this.expenseToEdit});

  final Expense? expenseToEdit;

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final expenseModel = getIt<ExpensesModel>();

  final categoryModel = getIt<ExpenseCategoryModel>();
  ExpenseCategory? selectedCategory;

  final note = TextEditingController();
  final expensesValue = TextEditingController();
  DateTime date = DateTime.now();
  final valueFocusNode = FocusNode();

  DateFormat dateFormatter = DateFormat.yMd('hr');

  @override
  void initState() {
    _loadCategory();

    expensesValue.text = widget.expenseToEdit?.expenseValue.toString() ?? "";
    note.text = widget.expenseToEdit?.expenseNote ?? "";
    date = widget.expenseToEdit?.date ?? DateTime.now();

    super.initState();
  }

  Future<void> _loadCategory() async {
    final initialCategory = await widget.expenseToEdit?.category;
    setState(() {
      selectedCategory = initialCategory;
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
              saveButton();
            },
            child: const Row(
              children: <Widget>[
                Icon(
                  Icons.save,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  "SAVE",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
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
                      _showIncomeScreen(context);
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
            child: StreamBuilder<List<ExpenseCategory>>(
                stream: categoryModel.allCategories(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }

                  return GridView.builder(
                    itemCount: snapshot.requireData.length,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    itemBuilder: (context, index) {
                      final expenseCategory = snapshot.requireData[index];
                      return Column(
                        children: [
                          Container(
                            height: 55,
                            width: 55,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: selectedCategory?.categoryId ==
                                        expenseCategory.categoryId
                                    ? Colors.tealAccent[200]
                                    : Colors.grey[300]),
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (selectedCategory?.categoryId ==
                                      expenseCategory.categoryId) {
                                    selectedCategory = null;
                                  } else {
                                    selectedCategory = expenseCategory;
                                  }
                                });
                              },
                              child: Text(expenseCategory.categoryName),
                            ),
                          ),
                        ],
                      );
                    },
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                  );
                }),
          ),
          AnimatedContainer(
            duration: selectedCategory == null
                ? const Duration(milliseconds: 500)
                : const Duration(milliseconds: 250),
            height: selectedCategory == null ? 100 : 0,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: FloatingActionButton(
                  backgroundColor: Colors.tealAccent[400],
                  onPressed: () {
                    _showIncomeCategoryScreen(context);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          AnimatedContainer(
            duration: selectedCategory == null
                ? const Duration(milliseconds: 500)
                : const Duration(milliseconds: 250),
            color: Colors.grey[100],
            height: selectedCategory == null ? 0 : 268,
            curve: selectedCategory == null ? Curves.easeInBack : Curves.easeIn,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Column(
                      children: <Widget>[
                        TextFormField(
                          controller: note,
                          textInputAction: TextInputAction.go,
                          onFieldSubmitted: (value) {
                            saveButton();
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
                          controller: expensesValue,
                          focusNode: valueFocusNode,
                          textInputAction: TextInputAction.go,
                          onFieldSubmitted: (value) {
                            saveButton();
                          },
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
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () async {
                              final selectedDate = await showDatePicker(
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
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 16.0),
                              backgroundColor: Colors.tealAccent[400],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Select Date",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                Icon(
                                  Icons.date_range_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        )
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

  void _showIncomeScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (context, animation1, animation2) {
          return IncomeScreen();
        },
        transitionDuration: Duration.zero,
      ),
    );
  }

  void _showIncomeCategoryScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        fullscreenDialog: true,
        builder: (BuildContext context) {
          return ExpenseCategoryScreen();
        },
      ),
    );
  }

  Future<String> saveButton() async {
    if (selectedCategory == null) {
      return "";
    }
    final userUuid =
        (await SharedPreferences.getInstance()).getString('userId');

    if (userUuid == null) {
      return "";
    }
    final expenseDb = Expense(
        widget.expenseToEdit?.id ?? Uuid().v4(),
        note.text,
        double.parse(expensesValue.value.text),
        selectedCategory!.categoryId,
        date.startOfDay,
        userUuid);
    if (widget.expenseToEdit == null) {
      expenseModel.addExpense(expenseDb);
    } else {
      expenseModel.updateExpenses(expenseDb);
    }
    Navigator.pop(context);
    return "";
  }
}
