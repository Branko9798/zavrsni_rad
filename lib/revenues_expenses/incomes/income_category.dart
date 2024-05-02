import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:zavrsni_rad/revenues_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/revenues_expenses/incomes/income_screen.dart';

class IncomeCategory {
  final IconData icon;
  final String name;
  final String id;

  const IncomeCategory(this.icon, this.name, this.id);
  static const categories = <IncomeCategory>[
    IncomeCategory(
      FontAwesomeIcons.moneyBill,
      'Salary',
      "2418684C-263F-407D-86EA-43713F82D9C8",
    ),
    IncomeCategory(
      FontAwesomeIcons.coins,
      "Investments",
      "8E261E63-7E9F-4548-9AF4-7C7A7E841F07",
    ),
    IncomeCategory(
      FontAwesomeIcons.moneyCheckDollar,
      "Part-time",
      "6BB5D981-3C6B-4AFB-96E8-4979FB2C4C36",
    ),
    IncomeCategory(
      FontAwesomeIcons.gift,
      "Gift",
      "414FC28D-A43C-4B63-AE7C-64D4DF3F8E0E",
    ),
  ];

  static IncomeCategory? findCategoryId(
    String id,
  ) {
    return categories.firstWhere((category) => category.id == id);
  }
}
