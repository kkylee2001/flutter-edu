import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Transactions {
  final String id;
  final String title;
  final double amount;
  final DateTime date;

  Transactions(
      {@required this.id,
      @required this.title,
      @required this.amount,
      @required this.date});
}

class TList extends StatefulWidget {
  final List<Transactions> tList;

  TList({this.tList});

  @override
  _TListState createState() => _TListState();
}

class _TListState extends State<TList> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ...widget.tList.map((tx) {
        return Card(
            child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black87,
                  width: 1,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Text(
                  "\$${tx.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.black54),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                ),
                Text(DateFormat.yMMMd().format(tx.date))
              ],
            )
          ],
        ));
      }).toList()
    ]);
  }
}
