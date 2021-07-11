import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function _addNewTransaction;

  NewTransaction(this._addNewTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  DateTime _pickedDate;

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  void _submit() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _pickedDate == null) {
      return;
    }

    widget._addNewTransaction(
      enteredTitle,
      enteredAmount,
      _pickedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((value) {
      if (value == null) {
        return;
      }
      setState(() {
        _pickedDate = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          elevation: 5,
          child: Container(
            padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TextField(
                  decoration: InputDecoration(labelText: 'Title'),
                  controller: _titleController,
                  onSubmitted: (_) => _submit(),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Amount'),
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  onSubmitted: (_) => _submit(),
                ),
                Container(
                  height: 70,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _pickedDate == null
                              ? 'No date chosen!'
                              : 'Chosen date: ${DateFormat.yMd().format(_pickedDate)}',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text('Choose Date'),
                        onPressed: _presentDatePicker,
                      ),
                    ],
                  ),
                ),
                FlatButton(
                  child: Text('Add Transaction'),
                  textColor: Colors.red,
                  onPressed: _submit,
                ),
              ],
            ),
          )),
    );
  }
}
