import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_model.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';

class IncomeScreen extends StatefulWidget {
  IncomeScreen({super.key, this.incomeToEdit});

  final Income? incomeToEdit;

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  final incomeModel = getIt<IncomeModel>();

  String? selectedIconId;
  String? selectedIconName;

  DateFormat dateFormatter = DateFormat.yMd('hr');

  final note = TextEditingController();
  final incomeValue = TextEditingController();
  final valueFocusNode = FocusNode();

  DateTime date = DateTime.now();

  int? selectedIndex;

  IncomeCategory? get selectedCategory =>
      selectedIndex == null ? null : IncomeCategory.categories[selectedIndex!];

  @override
  void initState() {
    selectedIndex = IncomeCategory.categories.indexWhere((element) =>
        element.id.toLowerCase() ==
        widget.incomeToEdit?.incomeCategoryId.toLowerCase());

    if (selectedIndex == -1) {
      selectedIndex = null;
    }

    incomeValue.text = widget.incomeToEdit?.incomeValue.toString() ?? "";
    note.text = widget.incomeToEdit?.incomeNote ?? "";
    date = widget.incomeToEdit?.date ?? DateTime.now();

    // TODO: implement initState
    super.initState();
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
                                } else {
                                  selectedIndex = index;
                                }
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
            duration: selectedIndex == null
                ? const Duration(milliseconds: 500)
                : const Duration(milliseconds: 250),
            color: Colors.grey[100],
            height: selectedIndex == null ? 0 : 300,
            curve: selectedIndex == 0 ? Curves.easeInBack : Curves.easeIn,
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
                          controller: incomeValue,
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
                              onPressed: incomeValue.clear,
                              icon: const Icon(Icons.clear),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomLeft,
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
    if (selectedCategory == null) {
      // TODO: Show error
      return;
    }
    final incomeDb = Income(
      widget.incomeToEdit?.id ?? Uuid().v4(),
      note.text,
      double.parse(incomeValue.value.text),
      selectedCategory!.id,
      date.startOfDay,
    );
    if (widget.incomeToEdit == null) {
      incomeModel.addIncome(incomeDb);
    } else {
      incomeModel.updateIncome(incomeDb);
    }
    Navigator.pop(context);
  }
}
