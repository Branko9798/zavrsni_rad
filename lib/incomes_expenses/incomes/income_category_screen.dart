import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category_model.dart';
import 'package:zavrsni_rad/main.dart';

class IncomeCategoryScreen extends StatefulWidget {
  IncomeCategoryScreen({super.key});

  @override
  State<IncomeCategoryScreen> createState() => _IncomeCategoryScreenState();
}

class _IncomeCategoryScreenState extends State<IncomeCategoryScreen> {
  Color currentColor = const Color.fromRGBO(68, 58, 255, 1);
  final categoryName = TextEditingController();

  final incomeCategoryModel = getIt<IncomeCategoryModel>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.tealAccent[400],
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          "Add category",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              saveButton();
              Navigator.of(context).pop();
            },
            child: const Row(
              children: [
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
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: categoryName,
              textInputAction: TextInputAction.go,
              onFieldSubmitted: (value) {
                saveButton();
              },
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: 'Category Name: ',
                suffixIcon: IconButton(
                  onPressed: categoryName.clear,
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _showColorPicker();
                  },
                  child: const Text("Pick Color"),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: currentColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveButton() async {
    final userUuid =
        (await SharedPreferences.getInstance()).getString('userId');

    currentColor.value;
    final incomeCategory = IncomeCategory(
      const Uuid().v4(),
      categoryName.text,
      currentColor.value,
      userUuid.toString(),
    );
    incomeCategoryModel.addIncomeCategory(incomeCategory);
  }

  void changeColor(Color color) {
    setState(() => currentColor = color);
  }

  Future _showColorPicker() {
    return showDialog(
      builder: (context) => AlertDialog(
        title: const Text('Pick a color!'),
        content: SingleChildScrollView(
          child: ColorPicker(
            pickerColor: currentColor,
            onColorChanged: changeColor,
            enableAlpha: false,
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey[300],
            ),
            child: const Text('Got it'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      context: context,
    );
  }
}
