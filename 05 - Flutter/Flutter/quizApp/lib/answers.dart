class AnswerTitle {
  final String title;
  final int score;

  AnswerTitle(this.title, this.score);
}

class QuestionTitle {
  final String text;
  final List<AnswerTitle> answers;

  QuestionTitle({this.text, this.answers});
}
