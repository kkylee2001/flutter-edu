import 'package:expense_planner/new_transaction.dart';

import 'package:flutter/material.dart';
import 'new_transaction.dart';
import 'tList.dart';

void main() {
  runApp(ExpenseTracker());
}

class ExpenseTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final tController = TextEditingController();

  final aController = TextEditingController();

  var transactions = [
    Transactions(
        id: "t1", title: "New Shoe", amount: 69.99, date: DateTime.now()),
    Transactions(
        id: "t2", title: "Grocery", amount: 100.00, date: DateTime.now()),
    Transactions(
        id: "t3", title: "Gym Shorts", amount: 100.00, date: DateTime.now()),
    Transactions(
        id: "t4",
        title: "Tik-Tok Materials",
        amount: 100.00,
        date: DateTime.now()),
  ];

  void addNew(String title, double amount) {
    setState(() {
      final newTX = Transactions(
          id: this.transactions.length.toString(),
          title: title,
          amount: amount,
          date: DateTime.now());
      transactions.add(newTX);
    });
  }

  void startNew(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTransaction(onPressed: addNew);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Flutter App"),
          actions: [
            IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                startNew(context);
              },
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Card(
                  child: Text("Chart"),
                ),
              ),
              TList(tList: transactions,)
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            startNew(context);
          },
        ));
  }
}
