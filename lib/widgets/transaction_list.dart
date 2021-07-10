import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransaction;
  final Function _deleteTransaction;

  TransactionList(this._userTransaction, this._deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: _userTransaction.isEmpty
          ? Column(
              children: [
                Text(
                  'There are no transactions yet!',
                  style: ThemeData.light().textTheme.bodyText1,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text('\$${_userTransaction[index].amount}'),
                        ),
                      ),
                    ),
                    title: Text(
                      _userTransaction[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(DateFormat.yMMMd()
                        .format(_userTransaction[index].date)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete_forever),
                      color: Theme.of(context).errorColor,
                      onPressed: () =>
                          _deleteTransaction(_userTransaction[index].id),
                    ),
                  ),
                );
              },
              itemCount: _userTransaction.length,
            ),
    );
  }
}
