import 'package:flutter/material.dart';
import 'package:quizz_app/colormodels.dart';
class cardOption extends StatelessWidget {
  const cardOption({Key? key, required this.option,required this.color}) : super(key: key);
  final String option;

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Text(
          option,
          textAlign:TextAlign.center,
          style: const TextStyle(
            fontSize: 22.0,

          ),
        ),
      ),
    );
  }
}
