import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatefulWidget {
  final List<Transaction> transactions;
  final Function removeCurrentTransaction;
  TransactionsList(this.transactions, this.removeCurrentTransaction);

  @override
  _TransactionsListState createState() => _TransactionsListState();
}

class _TransactionsListState extends State<TransactionsList> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: widget.transactions.isEmpty
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
                itemCount: widget.transactions.length,
                itemBuilder: (ctx, index) {
                  return Dismissible(
                    key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
                    onDismissed: (dir) {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return AlertDialog(
                              content: Text('Are you sure'),
                              actions: [
                                FlatButton(
                                  child: Text('Cancel'),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context).pop();
                                    });
                                  },
                                ),
                                FlatButton(
                                  onPressed: () {
                                    setState(() {
                                      widget.removeCurrentTransaction(
                                          widget.transactions[index].id);
                                      Navigator.pop(context);
                                    });
                                  },
                                  child: Text('Yes'),
                                ),
                              ],
                            );
                          });
                    },
                    direction: DismissDirection.startToEnd,
                    background: Container(
                      color: Colors.red,
                      child: Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text(
                                    '\$${widget.transactions[index].amount.toStringAsFixed(0)}')),
                          ),
                        ),
                        title: Text('${widget.transactions[index].title}'),
                        subtitle: Text(
                            '${DateFormat.yMMMd().format(widget.transactions[index].date)}'),
                      ),
                    ),
                  );
                },
            ),
    );

  }
}
