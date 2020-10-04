import 'package:flutter/material.dart';
import './answers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final q = [
    QuestionTitle(
        text: "Out of these, which is your favorite color?",
        answers: [
          AnswerTitle("Black", 0),
          AnswerTitle("Red", 1),
          AnswerTitle("White", 2)
        ]),
    QuestionTitle(text: "What is your favorite activity?", answers: [
      AnswerTitle("Sleep", 0),
      AnswerTitle("Eat", 1),
      AnswerTitle("Work", 2)
    ]),
    QuestionTitle(
        text: "Out of these, which is your favorite professor?",
        answers: [
          AnswerTitle("Kyle", 0),
          AnswerTitle("Khoo", 1),
          AnswerTitle("Shannon", 2)
        ])
  ];

  void answerPressed({int value = 0}) {
    setState(() {
      if (index <= q.length - 1) {
        score += value;
        index += 1;
        print(this.score);
      }
    });
  }

  void resetQuiz() {
    setState(() {
      this.index = 0;
      this.score = 0;
    });
  }

  var index = 0;
  var score = 0;

  Widget scoreText(int value) {
    if (value == 0) {
      return Text("You're Trash");
    } else if (value > 0 && value <= 5) {
      return Text("Meh...not too bad");
    } else {
      return Text("Amazing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My Quiz App"),
        ),
        body: index < q.length
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Question(question: q[index].text),
                    ...(q[index].answers).map((answer) {
                      return Answer(
                          answer: answer.title,
                          onPressed: () => answerPressed(value: answer.score));
                    }).toList()
                  ],
                ),
              )
            : Center(
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "You Did It!",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    scoreText(this.score),
                    Spacer(),
                    FlatButton(
                        onPressed: resetQuiz, child: Text("Restart Quiz")),
                    Spacer()
                  ],
                ),
              ),
      ),
    );
  }
}

class Question extends StatelessWidget {
  final String question;
  Question({this.question});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        question,
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}

class Answer extends StatelessWidget {
  final Function onPressed;
  final String answer;

  Answer({this.answer, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
          color: Colors.blue,
          textColor: Colors.white,
          child: Text(this.answer),
          onPressed: this.onPressed),
    );
  }
}
