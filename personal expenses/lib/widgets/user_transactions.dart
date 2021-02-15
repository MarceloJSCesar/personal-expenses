import 'package:flutter/material.dart';
import '../models/transaction.dart';
import './transactions_list.dart';

class UserTransactions extends StatefulWidget {
  final List<Transaction> transaction;
  UserTransactions(this.transaction);
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  void _removeCurrentTransaction(String id) {
    setState(() {
      widget.transaction.removeWhere((data) {
        return data.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TransactionsList(widget.transaction, _removeCurrentTransaction)
      ],
    );
  }
}
