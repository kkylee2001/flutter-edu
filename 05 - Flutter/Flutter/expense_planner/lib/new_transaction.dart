import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function onPressed;

  NewTransaction({this.onPressed});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final tController = TextEditingController();

  final aController = TextEditingController();

  void submitData() {
    final t = tController.text;
    final a = double.parse(aController.text);

    if (t.isEmpty || a <= 0) {
      return;
    }
    widget.onPressed(tController.text, double.parse(aController.text));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextField(
              decoration: InputDecoration(labelText: "Expense Name"),
              controller: tController,
              onSubmitted: (_) => submitData()),
          TextField(
            decoration: InputDecoration(labelText: "Amount"),
            controller: aController,
            keyboardType: TextInputType.number,
            onSubmitted: (_) => submitData(),
          ),
          FlatButton(
            child: Text("Submit"),
            onPressed: submitData,
          ),
        ],
      ),
    ));
  }
}
