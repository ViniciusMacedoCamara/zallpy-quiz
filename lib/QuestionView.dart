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
  int correctCounter = 0;

  // QuestionData questionData;

  @override
  void initState() {
    viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.inic));
    print(viewQuestion);
    viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(widget.inic));
    print(viewCorrect);
    changeText();
  }

  changeText() {
    if (widget.inic < 4) {
      setState(() {
        // this.test = widget.question[0]['question'].toString();
        this.viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.inic));
        this.viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(widget.inic));
      });
      widget.inic++;
    } else {
      print('Para tudo');
      print(this.correctCounter);
    }
  }

  score(int i) {
    if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[i]) {
      this.correctCounter++;
    } else {
      print('errado\n');
    }
    changeText();
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
                'In which country\n' + viewQuestion + '\nwas created?\n$viewCorrect - $viewAnswer',
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
                      score(0);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[1]),
                    onPressed: () {
                      score(1);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[2]),
                    onPressed: () {
                      score(2);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(widget.inic))[3]),
                    onPressed: () {
                      score(3);
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
