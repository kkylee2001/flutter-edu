import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  var text = "Press the button";
  var buttonTitle = "Change Text";

  void changeText() {
    setState(() {
      if (this.text == "Press the button") {
        this.buttonTitle = "Reset Text";
        this.text = "You have pressed the button";
      } else {
        this.text = "Press the button";
        this.buttonTitle = "Change Text";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("Flutter Assignment"),
            ),
            body: Center(
                child: Column(
              children: [
                Spacer(),
                Text(text),
                TextControl(this.changeText, this.buttonTitle),
                Spacer()
              ],
            ))));
  }
}

class TextControl extends StatelessWidget {
  final String text;
  final Function onPressed;
  TextControl(this.onPressed, this.text);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(child: Text(text), onPressed: this.onPressed),
    );
  }
}
