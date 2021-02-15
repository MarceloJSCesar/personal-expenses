import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactions;
  TransactionsList(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    )),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'No transactions added yet',
                  style: Theme.of(context).textTheme.headline6,
                )
              ],
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Container(
                        padding: EdgeInsets.all(6),
                        child: Icon(Icons.attach_money_outlined, color: Colors.white), 
                      ),
                    ),
                    title: Text(
                      '${transactions[index].title}'
                    ),
                    subtitle: Text(
                      '${DateFormat.yMMMd().format(transactions[index].date)}'
                    ),
                  ),
                );
              },
            ),
    );
  }
}
