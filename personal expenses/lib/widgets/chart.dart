import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';
import './chart_bar.dart';

class Chart extends StatefulWidget {
  final List<Transaction> recentTransaction;
  Chart(this.recentTransaction);

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<Map> get groupTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      var totalsum = 0.0;

      for (var i = 0; i < widget.recentTransaction.length; i++) {
        if (widget.recentTransaction[i].date.day == weekDay.day &&
            widget.recentTransaction[i].date.month == weekDay.month &&
            widget.recentTransaction[i].date.year == weekDay.year) {
          totalsum += widget.recentTransaction[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalsum
      };
    });
  }

  double get _totalSpendingAmount {
    return groupTransactionValue.fold(0.0, (sum, item) {
      return sum += item['amount'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupTransactionValue.map((data) {
            return Flexible(
              flex: 3,
              fit: FlexFit.tight,
              child: ChartBar(
                label: data['day'],
                spendingAmount: data['amount'],
                spendingPctOfTotal: _totalSpendingAmount == 0.0
                    ? 0.0
                    : (data['amount'] as double) / _totalSpendingAmount,
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
