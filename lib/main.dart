import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/home.dart';
import 'package:zavrsni_rad/statistics/statistics_model.dart';
import 'package:zavrsni_rad/statistics/statistics_screen.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_model.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_model.dart';

import 'package:get_it/get_it.dart';

import 'package:zavrsni_rad/user_screen.dart';

GetIt getIt = GetIt.instance;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  getIt.registerSingleton<AppDatabase>(AppDatabase());
  getIt.registerSingleton<IncomeModel>(IncomeModel());
  getIt.registerSingleton<ExpensesModel>(ExpensesModel());
  getIt.registerSingleton<StatisticsModel>(StatisticsModel());

  getIt<StatisticsModel>().incomesTotal().listen(
    (event) {
      print("TEST");
      print(event);
    },
  );
  getIt<StatisticsModel>().expensesTotal().listen((event) {
    print("TEST 2");
    print(event);
  });

 
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int myIndex = 0;

class _MyAppState extends State<MyApp> {
  final _pageController = PageController();

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
        body: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: [Home(), const StatisticsScreen(), const UserScreen()],
          onPageChanged: (index) {
            setState(() {
              myIndex = index;
            });
          },
        ),
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
            _pageController.jumpToPage(index);
          },
          currentIndex: myIndex,
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
                  Icons.bar_chart_rounded,
                  color: Colors.white,
                ),
                label: 'Statistics'),
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
