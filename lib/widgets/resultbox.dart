import 'package:flutter/material.dart';

import '../colormodels.dart';

class resultBox extends StatelessWidget {
  const resultBox(
      {Key? key, required this.result, required this.questionLength,required this.onPressed})
      : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: EdgeInsets.all(60.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Result',
              style: TextStyle(color: neutral, fontSize: 25.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              child: Text(
                '$result/$questionLength',
                style: TextStyle(fontSize: 30.0),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength / 2
                  ? Colors.yellow
                  : result < questionLength / 2
                      ? incorrect
                      : correct,
            ),
            const SizedBox(height: 20.0,),
            Text(result == questionLength / 2
                ? 'Almost There'
                : result < questionLength / 2
                ? 'Try Again'
                : 'Great',
              style: TextStyle(color: neutral,fontSize: 20),
            ),
            const SizedBox(height: 25.0,),
            GestureDetector(
              onTap: onPressed,
              child: const Text('Start Over',style: TextStyle(color: Colors.pink,fontSize: 20,letterSpacing: 1.0),),

            ),
          ],
        ),
      ),
    );
  }
}
