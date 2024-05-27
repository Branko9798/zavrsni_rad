import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/main.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:zavrsni_rad/incomes_expenses/expenses/expense_category.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';

class StatisticsModel {
  final db = getIt<AppDatabase>();

  Stream<double> incomesTotal() {
    final incomeSum = db.incomesTable.incomeValue.sum();

    return db.incomesTable
        .select()
        .addColumns([incomeSum])
        .map((p0) => p0.read(incomeSum))
        .watchSingle()
        .map((event) {
          if (event == null) {
            return 0;
          } else {
            return event;
          }
        });
  }

  Stream<double> expensesTotal() {
    final expensesSum = db.expensesTable.expenseValue.sum();

    return db.expensesTable
        .select()
        .addColumns([expensesSum])
        .map((p0) => p0.read(expensesSum))
        .watchSingle()
        .map((event) {
          if (event == null) {
            return 0;
          } else {
            return event;
          }
        });
  }

  Stream<double> total() {
    return incomesTotal().combineLatest(expensesTotal(), (p0, p1) => p0 - p1);
  }

  Stream<PieChartData?> expensesByCategory(DateTime date) {
    return (db.expensesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .map((expenses) {
      var expensesTotalByCategory = <ExpenseCategory, double>{};

      if (expenses.isEmpty) {
        return null;
      }

      final grandTotal = expenses
          .map((e) => e.expenseValue)
          .reduce((value, element) => value + element);

      for (var expense in expenses) {
        if (expense.category == null) {
          continue;
        }

        if (expensesTotalByCategory[expense.category!] == null) {
          expensesTotalByCategory[expense.category!] = 0.0;
        }
        expensesTotalByCategory[expense.category!] =
            expensesTotalByCategory[expense.category!]! + expense.expenseValue;
      }

      final sectionData = expensesTotalByCategory.entries.map(
        (entry) {
          final key = entry.key;
          final value = entry.value;
          final percentage = (entry.value / grandTotal) * 100;
          return CustomPieChartSectionData(
            value: value,
            title: "${percentage.toStringAsFixed(0)}%",
            titleStyle: const TextStyle(color: Colors.white),
            color: key.color,
            legendTitle: key.name,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }

  Stream<PieChartData> incomesByCategory(DateTime date) {
    return (db.incomesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .map((incomes) {
      var incomesTotalByCategory = <IncomeCategory, double>{};

      final grandTotal = incomes
          .map((e) => e.incomeValue)
          .reduce((value, element) => value + element);

      for (var income in incomes) {
        if (income.category == null) {
          continue;
        }

        if (incomesTotalByCategory[income.category!] == null) {
          incomesTotalByCategory[income.category!] = 0.0;
        }
        incomesTotalByCategory[income.category!] =
            incomesTotalByCategory[income.category!]! + income.incomeValue;
      }

      final sectionData = incomesTotalByCategory.entries.map(
        (entry) {
          final key = entry.key;
          final value = entry.value;
          final percentage = (entry.value / grandTotal) * 100;
          return CustomPieChartSectionData(
            value: value,
            title: "${percentage.toStringAsFixed(0)}%",
            titleStyle: const TextStyle(color: Colors.white),
            color: key.color,
            legendTitle: key.name,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }

  Stream<LineChartData> incomeLineChartPoints(DateTime date) {
    final db = getIt<AppDatabase>();
    return (db.incomesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .map((incomes) {
      List<FlSpot> incomeData = incomes
          .fold(<DateTime, double>{}, (previousValue, element) {
            final date = element.date.startOfDay;

            if (previousValue[date] == null) {
              previousValue[date] = 0;
            }
            previousValue[date] = previousValue[date]! + element.incomeValue;

            return previousValue;
          })
          .entries
          .map((entry) => FlSpot(
                entry.key.day.toDouble(),
                entry.value,
              ))
          .sorted((a, b) => a.x.compareTo(b.x))
          .toList();

      return LineChartData(
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: incomeData,
            barWidth: 3,
            isCurved: false,
          ),
        ],
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xff68737d),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 50,
              showTitles: true,
            ),
          ),
        ),
      );
    });
  }

  Stream<LineChartData> expenseLineChartPoints(DateTime date) {
    final db = getIt<AppDatabase>();
    return (db.expensesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .map((expenses) {
      List<FlSpot> expenseData = expenses
          .fold(<DateTime, double>{}, (previousValue, element) {
            final date = element.date.startOfDay;

            if (previousValue[date] == null) {
              previousValue[date] = 0;
            }
            previousValue[date] = previousValue[date]! + element.expenseValue;

            return previousValue;
          })
          .entries
          .map((entry) => FlSpot(
                entry.key.day.toDouble(),
                entry.value,
              ))
          .sorted((a, b) => a.x.compareTo(b.x))
          .toList();

      return LineChartData(
        minY: 0,
        lineBarsData: [
          LineChartBarData(
            spots: expenseData,
            barWidth: 3,
            isCurved: false,
          ),
        ],
        titlesData: FlTitlesData(
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (double value, TitleMeta meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xff68737d),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                );
              },
            ),
          ),
          leftTitles: const AxisTitles(
            sideTitles: SideTitles(
              reservedSize: 50,
              showTitles: true,
            ),
          ),
        ),
      );
    });
  }
}

class CustomPieChartSectionData extends PieChartSectionData {
  final String legendTitle;

  CustomPieChartSectionData({
    super.value,
    super.color,
    super.gradient,
    super.radius,
    super.showTitle,
    super.titleStyle,
    super.title,
    super.borderSide,
    super.badgeWidget,
    super.titlePositionPercentageOffset,
    super.badgePositionPercentageOffset,
    this.legendTitle = "",
  });

  /// Copies current [PieChartSectionData] to a new [PieChartSectionData],
  /// and replaces provided values.
  @override
  CustomPieChartSectionData copyWith({
    double? value,
    Color? color,
    Gradient? gradient,
    double? radius,
    bool? showTitle,
    TextStyle? titleStyle,
    String? title,
    BorderSide? borderSide,
    Widget? badgeWidget,
    double? titlePositionPercentageOffset,
    double? badgePositionPercentageOffset,
    String? legendTitle,
  }) {
    return CustomPieChartSectionData(
        value: value ?? this.value,
        color: color ?? this.color,
        gradient: gradient ?? this.gradient,
        radius: radius ?? this.radius,
        showTitle: showTitle ?? this.showTitle,
        titleStyle: titleStyle ?? this.titleStyle,
        title: title ?? this.title,
        borderSide: borderSide ?? this.borderSide,
        badgeWidget: badgeWidget ?? this.badgeWidget,
        titlePositionPercentageOffset:
            titlePositionPercentageOffset ?? this.titlePositionPercentageOffset,
        badgePositionPercentageOffset:
            badgePositionPercentageOffset ?? this.badgePositionPercentageOffset,
        legendTitle: legendTitle ?? this.legendTitle);
  }
}

// TODO: Move to utils folder
extension StartOfDay on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
}
