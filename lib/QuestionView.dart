import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'QuestionData.dart';
import 'Question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:zallpy_quiz/QuestionData.dart';
import 'dart:developer' as dev;
import 'QuestionData.dart';

// class QuestionView extends StatefulWidget {
//   QuestionView({@required this.question});
//
//   final String question;
//
//   @override
//   State createState() {}
// }

class QuestionView extends StatefulWidget {
  final List questionPos;
  final List question;
  final List correct;
  final List answer;
  int inic;

  QuestionView({Key key, this.questionPos, this.question, this.inic, this.correct, this.answer}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  String viewQuestion;
  String viewCorrect;
  String viewAnswer;

  // QuestionData questionData;

  @override
  void initState() {
    viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.inic));
    viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(widget.inic));
    // viewAnswer = widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[0];
  }

  changeText() {
    print(widget.questionPos.elementAt(widget.inic));
    print(widget.question.elementAt(widget.questionPos.elementAt(widget.inic)));
    print(widget.correct.elementAt(widget.questionPos.elementAt(widget.inic)));
    print(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[0]);
    if (widget.inic <= 4) {
      setState(() {
        // this.test = widget.question[0]['question'].toString();
        this.viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.inic));
      });
      widget.inic++;
    } else {
      print('Para tudo');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'In which country\n' + viewQuestion + '\nwas created?',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[0]),
                    onPressed: () {
                      if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[0]) {
                        print('correto\n');
                      } else {
                        print('errado\n');
                        // print(snapshot.data.results.elementAt(0).correct);
                      }
                      changeText();
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[1]),
                    onPressed: () {
                      if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[1]) {
                        print('correto\n');
                      } else {
                        print('errado\n');
                        // print(snapshot.data.results.elementAt(0).correct);
                      }
                      changeText();
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[2]),
                    onPressed: () {
                      // print(snapshot.data.results.elementAt(0).correct);
                      // print(a.elementAt(2));
                      if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[2]) {
                        print('correto\n');
                      } else {
                        print('errado\n');
                        // print(snapshot.data.results.elementAt(0).correct);
                      }
                      changeText();
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[3]),
                    onPressed: () {
                      if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[3]) {
                        print('correto\n');
                      } else {
                        print('errado\n');
                        // print(snapshot.data.results.elementAt(0).correct);
                      }
                      changeText();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
