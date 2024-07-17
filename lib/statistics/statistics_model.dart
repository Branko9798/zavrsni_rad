import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:zavrsni_rad/database/database.dart';
import 'package:zavrsni_rad/incomes_expenses/incomes/income_category.dart';
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

  Stream<Map<String, double>> averageValuesForCurrentMonth() {
    final DateTime now = DateTime.now();
    final int daysInMonth = DateTime(now.year, now.month + 1, 0).day;

    final incomeTotalStream = incomesTotal();
    final expenseTotalStream = expensesTotal();

    return incomeTotalStream.combineLatest(expenseTotalStream,
        (incomeTotal, expenseTotal) {
      final double averageIncome = incomeTotal / daysInMonth;
      final double averageExpense = expenseTotal / daysInMonth;

      return {
        'averageIncome': averageIncome,
        'averageExpense': averageExpense,
      };
    });
  }

  Stream<PieChartData?> expensesByCategory(DateTime date) {
    return (db.expensesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .asyncMap((expenses) async {
      var expensesTotalByCategory = <ExpenseCategory, double>{};

      if (expenses.isEmpty) {
        return null;
      }

      final grandTotal = expenses
          .map((e) => e.expenseValue)
          .reduce((value, element) => value + element);

      for (var expense in expenses) {
        final category = await expense.category;
        if (category == null) {
          continue;
        }

        if (expensesTotalByCategory[category] == null) {
          expensesTotalByCategory[category] = 0.0;
        }
        expensesTotalByCategory[category] =
            expensesTotalByCategory[category]! + expense.expenseValue;
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
            color: Color(key.categoryColor),
            legendTitle: key.categoryName,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }

  Stream<PieChartData?> incomesByCategory(DateTime date) {
    return (db.incomesTable.select()
          ..where((tbl) =>
              tbl.date.month.equals(date.month) &
              tbl.date.year.equals(date.year)))
        .watch()
        .asyncMap((incomes) async {
      var incomesTotalByCategory = <IncomeCategory, double>{};

      if (incomes.isEmpty) {
        return null;
      }

      final grandTotal = incomes
          .map((e) => e.incomeValue)
          .reduce((value, element) => value + element);

      for (var income in incomes) {
        final category = await income.category;
        if (category == null) {
          continue;
        }

        if (incomesTotalByCategory[category] == null) {
          incomesTotalByCategory[category] = 0.0;
        }
        incomesTotalByCategory[category] =
            incomesTotalByCategory[category]! + income.incomeValue;
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
            color: Color(key.categoryColor),
            legendTitle: key.categoryName,
          );
        },
      ).toList();

      return PieChartData(sections: sectionData);
    });
  }

  Stream<PieChartData?> incomeExpensePieChart(DateTime date) {
    return incomesTotal().combineLatest(expensesTotal(),
        (incomeTotal, expenseTotal) {
      final List<PieChartSectionData> sections = [];

      if (incomeTotal > 0) {
        sections.add(PieChartSectionData(
          value: incomeTotal,
          title:
              '${((incomeTotal / (incomeTotal + expenseTotal)) * 100).toStringAsFixed(0)}%',
          color: Colors.green,
          titleStyle: const TextStyle(color: Colors.white),
        ));
      }

      if (expenseTotal > 0) {
        sections.add(PieChartSectionData(
          value: expenseTotal,
          title:
              '${((expenseTotal / (incomeTotal + expenseTotal)) * 100).toStringAsFixed(0)}%',
          color: Colors.red,
          titleStyle: const TextStyle(color: Colors.white),
        ));
      }

      return PieChartData(sections: sections);
    });
  }

  Stream<LineChartData?> incomeLineChartPoints(DateTime date) {
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

      if (incomes.isEmpty) {
        return null;
      }

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

  Stream<LineChartData?> expenseLineChartPoints(DateTime date) {
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

      if (expenseData.isEmpty) {
        return null;
      }

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
