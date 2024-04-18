import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/home.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/revnues/revenue_model.dart';
import 'package:zavrsni_rad/revenues_expenses/revenues_screen.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<RevenueModel>(RevenueModel());
  getIt.registerSingleton<ExpensesModel>(ExpensesModel());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int myInedx = 0;

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 2, 103, 142),
          brightness: Brightness.dark,
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 2, 103, 142),
        ),
        useMaterial3: true,
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          selectedLabelStyle: const TextStyle(color: Colors.white),
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          unselectedFontSize: 14,
          selectedFontSize: 15,
          unselectedIconTheme:
              const IconThemeData(size: 30, color: Colors.white),
          selectedIconTheme:
              const IconThemeData(size: 27, color: Colors.white, fill: 1),
          backgroundColor: Colors.tealAccent[400],
          onTap: (index) {
            setState(() {
              myInedx = index;
            });
          },
          currentIndex: myInedx,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.notifications_rounded,
                  color: Colors.white,
                ),
                label: 'Notifications'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                label: 'User')
          ],
        ),
      ),
    );
  }
}
