import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:statistic_store/widgets/new_transaction.dart';
import './models/transaction.dart';
import './widgets/chart.dart';
import 'package:statistic_store/widgets/user_transactions.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: ThemeData(
          primarySwatch: Colors.purple,
          errorColor: Colors.red,
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontSize: 16,
                  fontFamily: 'OpenSans-Regular',
                  color: Colors.black),
              button: TextStyle(color: Colors.white)),
          appBarTheme: AppBarTheme(
              centerTitle: true,
              textTheme: ThemeData.light().textTheme.copyWith(
                      headline6: TextStyle(
                    fontFamily: 'Quicksand-Bold',
                    fontSize: 18,
                  )))),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Transaction> userTransactions = [
    // Transaction(
    //   id: '1234',
    //   title: 'Coat',
    //   amount: 39.89,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '5678',
    //   title: 'Mac',
    //   amount: 1.897,
    //   date: DateTime.now(),
    // ),
  ];

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final txData = Transaction(
        title: txTitle,
        amount: txAmount,
        id: DateTime.now().toString(),
        date: chosenDate);

    setState(() {
      userTransactions.add(txData);
      // _saveData();
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            child: NewTransaction(_addNewTransaction),
            onTap: () {},
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  List<Transaction> get _recentTransactions {
    return userTransactions.where((transactions) {
      return transactions.date
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Personal Expenses',
          style: Theme.of(context).textTheme.headline6,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Chart(_recentTransactions),
                 UserTransactions(userTransactions)
              ]),
        ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.add),
        label: Text('Add'),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }

  // Future<File> _getFile() async {
  //   final directory = await getApplicationDocumentsDirectory();
  //   return File('${directory.path}/data.json');
  // }

  // Future<File> _saveData() async {
  //   final file = json.encode(userTransactions);
  //   final data = await _getFile();
  //   return data.writeAsString(file);
  // }

  // Future<String> _readData() async {
  //   try {
  //     final data = await _getFile();
  //     return data.readAsString();
  //   } catch (error) {
  //     print('error caused by readingDat: $error');
  //     return null;
  //   }
  // }
}
