import 'package:quizz_app/models/modelquestions.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class DBconnect{
  //CREATE A FUNCTION TO ADD A QUESTION TO OUR DB.
  final url = Uri.parse('https://quizzapp-6a8f6-default-rtdb.firebaseio.com/questions.json');


  //FETCH THE DATA FROM DB
Future<List<Question>> fetchQuestions() async {
    return http.get(url).then((response){
      var data = json.decode(response.body)as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        var newQuestion = Question(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options']),
        );
        newQuestions.add(newQuestion);
      });
      return newQuestions;
    });

}

}
