import 'package:flutter/cupertino.dart';
import 'package:quizz_app/colormodels.dart';

class Questionwidget extends StatelessWidget {
  const Questionwidget(
      {Key? key,
      required this.question,
      required this.indexAction,
      required this.totalQuestions})
      : super(key: key);

  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text('Question ${indexAction + 1}/$totalQuestions: $question',
      style: TextStyle(
        fontSize: 24.0,
        color: neutral,
      ),),
    );
  }
}
