import 'package:flutter/material.dart';
import 'package:quizz_app/models/db_connect.dart';
import 'package:quizz_app/widgets/questionwidget.dart';

import '../colormodels.dart';
import '../models/modelquestions.dart';
import '../widgets/next_button.dart';
import '../widgets/optioncard.dart';
import '../widgets/resultbox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var db = DBconnect();
 // List<Question> _questions = [
   // Question(
    //    id: '10',
    //    title: 'OS computer abbreviation usually means?',
     //   options: {
      //    'Order of Significance': false,
      //    'Open Software': false,
     //     'Operating System': true,
      //    'Optical Sensor': false
      //  }),
   // Question(id: '11', title: ' What does SSL stand for?', options: {
    //  'Secure Socket Layer': true,
    //  'System Socket Layer': false,
    //  'Superuser System Login': false,
   //   'Secure System Login': false
  //  }),
 // ];
  late Future _questions;
  Future<List<Question>> getData()async{
    return db.fetchQuestions();
  }
  @override
  void initState() {
   _questions = getData();
    super.initState();
  }
  int index = 0;
  int score = 0;
  bool isPressed = false;
  bool isAlreadySelect= false;

  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      showDialog(context: context,
          barrierDismissible: false,
          builder: (ctx)=>resultBox(
        result: score,
        questionLength: questionLength,
            onPressed: startOver,
      ));
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelect=false;
        });
      } else {
        ScaffoldMessenger
            .of(context)
            .showSnackBar(
            const SnackBar(
              content: Text('Please select any option',textAlign: TextAlign.center,),
              behavior:SnackBarBehavior.floating,
              margin: EdgeInsets.symmetric(vertical: 20.0),
            ));
      }
        }
        }

  void checkAnswerAndUpdate(bool value) {
    if(isAlreadySelect){
      return;
    }else{
      if(value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelect=true;
      });

    }

    }


  void startOver() {
    setState(() {
      index=0;
      score=0;
      isPressed = false;
      isAlreadySelect = false;
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(child: Text('${snapshot}'),);
          }else if(snapshot.hasData){
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: Text('QuiZz huB'),
                backgroundColor: background,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(padding: EdgeInsets.all(18.0),child: Text('Score : $score',
                    style: const TextStyle(fontSize: 18.0),
                  ),),
                ],
              ),
              body: Container(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: [
                      Questionwidget(
                        indexAction: index,
                        question: extractedData[index].title,
                        totalQuestions: extractedData.length,
                      ),
                      Divider(
                        color: neutral,
                      ),
                      const SizedBox(
                        height: 25.0,
                      ),
                      for (int i = 0; i < extractedData[index].options.length; i++)
                        GestureDetector(
                          onTap:()=>checkAnswerAndUpdate(
                              extractedData[index].options.values.toList()[i]),
                          child: cardOption(
                            option: extractedData[index].options.keys.toList()[i],
                            color: isPressed
                                ? extractedData[index].options.values.toList()[i] == true
                                ? correct
                                : incorrect
                                : neutral,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () =>nextQuestion(extractedData.length),
                child:  const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(

                  ),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
        }
        else
          {
            return  Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  Text('Please wait while questions are loading...',
                    style: TextStyle(color: Theme.of(context).primaryColor,
                    decoration: TextDecoration.none,
                    fontSize: 14),
                  ),
                ],
              ),
            );
          }
        return const Center(child: Text('No Data'),);
      },

    );
  }
}
