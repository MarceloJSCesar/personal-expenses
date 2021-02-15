import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addNewTransaction;
  NewTransaction(this.addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _pickedDate;
  final _focusNode = FocusNode();

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final txTitle = _titleController.text;
    final txAmount = double.parse(_amountController.text);

    if (txTitle.isEmpty || txAmount <= 0 || _pickedDate == null) {
      return;
    }

    widget.addNewTransaction(txTitle, txAmount, _pickedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021, DateTime.now().month),
            lastDate: DateTime.now())
        .then((pickedDate) {
      setState(() {
        _pickedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              onSubmitted: (val) => _submitData(),
              keyboardType: TextInputType.text,
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              focusNode: _focusNode,
              onSubmitted: (val) => _submitData(),
              keyboardType: TextInputType.number,
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_pickedDate != null
                        ? 'PickedDate: ${DateFormat.yM().format(_pickedDate)}'
                        : 'No date chosen!'),
                  ),
                  FlatButton(
                    child: Text(
                      'Choose date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('Add Transaction'),
              textColor: Colors.purple,
              onPressed: _submitData
            ),
          ],
        ),
      ),
    );
  }
}
