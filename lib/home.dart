import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expenses_screen.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_model.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_screen.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ValueNotifier<String?> categoryFilter = ValueNotifier(null);

  File? image;
  String? selectedCategory;

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
        drawer: Drawer(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: image != null
                                  ? FileImage(image!)
                                  : const AssetImage(
                                          'path_to_placeholder_image')
                                      as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(pickImage);
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add_a_photo,
                                color: Colors.blue,
                              ),
                              SizedBox(width: 15),
                              Text(
                                'Load photo',
                                style: TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Filters: ',
                  style: TextStyle(fontWeight: FontWeight.bold),
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
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 40,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Incomes',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ),
                  Expanded(
                      child: Text(
                    'Expenses',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ))
                ],
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                children: [
                  StreamBuilder(
                    stream: selectedCategory == null
                        ? getIt<IncomeModel>().allIncomesStream
                        : getIt<IncomeModel>()
                            .filteredIncomes([selectedCategory!]),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if (!snapshot.hasData) {
                            return const CircularProgressIndicator();
                          }

                          final income = snapshot.data![index];

                          return Card(
                            color: Colors.tealAccent[200],
                            child: InkWell(
                              onLongPress: () {},
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
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
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '+${income.incomeValue} €',
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
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Center(
                                          child: FaIcon(income.category!.icon)),
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
                  StreamBuilder(
                    stream: selectedCategory == null
                        ? getIt<ExpensesModel>().allExpensesStream
                        : getIt<ExpensesModel>()
                            .filteredExpenses([selectedCategory!]),
                    builder: (context, snapshot) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          final expense = snapshot.data![index];

                          return Card(
                            color: Colors.red[100],
                            child: InkWell(
                              onLongPress: () {},
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
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
                                    flex: 1,
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                      ),
                                      child: Center(
                                          child:
                                              FaIcon(expense.category!.icon)),
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

  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage == null) {
      return;
    } else {
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = const Uuid().v4();
      final savedImage = File('${appDir.path}/$fileName.png');

      await savedImage.writeAsBytes(await pickedImage.readAsBytes());

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('itemImage_$image', savedImage.path);

      setState(() {
        image = savedImage;
      });
    }
  }
}
