import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpensesScreen extends StatefulWidget {
  ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class Category {
  final IconData icon;
  final String name;
  final String id;

  const Category(this.icon, this.name, this.id);
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  final expense = TextEditingController();

  final expenseModel = getIt<ExpensesModel>();

  int? selectedIndex;
  bool selectedButton = false;

  static final categories = <Category>[
    Category(FontAwesomeIcons.house, "House", const Uuid().v4()),
    Category(FontAwesomeIcons.receipt, "Bills", const Uuid().v4()),
    Category(Icons.face_2, "Girlfriend", const Uuid().v4()),
    Category(Icons.face_6, "Boyfriend", const Uuid().v4()),
    Category(FontAwesomeIcons.babyCarriage, "Babysitter", const Uuid().v4()),
    Category(FontAwesomeIcons.child, "Child", const Uuid().v4()),
    Category(FontAwesomeIcons.personCane, "Family", const Uuid().v4()),
    Category(FontAwesomeIcons.dog, "Pet", const Uuid().v4()),
    Category(FontAwesomeIcons.burger, "Food", const Uuid().v4()),
    Category(FontAwesomeIcons.mugSaucer, "Drinks", const Uuid().v4()),
    Category(FontAwesomeIcons.car, "Car", const Uuid().v4()),
    Category(FontAwesomeIcons.trainSubway, "Transport", const Uuid().v4()),
    Category(FontAwesomeIcons.cartShopping, "Grocery", const Uuid().v4()),
    Category(FontAwesomeIcons.briefcase, "Buisness", const Uuid().v4()),
    Category(FontAwesomeIcons.gifts, "Gifts", const Uuid().v4()),
    Category(FontAwesomeIcons.shirt, "Clothes", const Uuid().v4()),
    Category(FontAwesomeIcons.scissors, "Haircut", const Uuid().v4()),
    Category(FontAwesomeIcons.computer, "Tehnology", const Uuid().v4()),
    Category(FontAwesomeIcons.paintRoller, "Housing", const Uuid().v4()),
    Category(FontAwesomeIcons.couch, "Furniture", const Uuid().v4()),
    Category(FontAwesomeIcons.wineBottle, "Party", const Uuid().v4()),
    Category(FontAwesomeIcons.futbol, "Sport", const Uuid().v4()),
    Category(FontAwesomeIcons.airbnb, "Vacation", const Uuid().v4()),
    Category(FontAwesomeIcons.hammer, "Repair", const Uuid().v4()),
    Category(FontAwesomeIcons.heartPulse, "Health", const Uuid().v4()),
    Category(FontAwesomeIcons.handHoldingDollar, "Donate", const Uuid().v4()),
    Category(FontAwesomeIcons.planeUp, "Travel", const Uuid().v4()),
    Category(FontAwesomeIcons.dice, "Gambling", const Uuid().v4()),
  ];

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
        child: GridView.builder(
          itemCount: categories.length,
          itemBuilder: (context, index) {
            final category = categories[index];

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
                            selectedIndex = index;
                          });
                        },
                        icon: FaIcon(
                          category.icon,
                        ))),
                Text(category.name),
                AnimatedPositioned(
                  left: selectedButton ? 50 : 0,
                  bottom: selectedButton ? 50 : 0,
                  top: selectedButton ? 50 : 0,
                  right: selectedButton ? 50 : 0,
                  duration: const Duration(milliseconds: 500),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedButton = !selectedButton;
                      });
                    },
                  ),
                ),
              ],
            );
          },
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: 0,
            crossAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
