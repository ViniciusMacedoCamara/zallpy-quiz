import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zallpy_quiz/main.dart';
import 'QuestionData.dart';
import 'Question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:zallpy_quiz/QuestionData.dart';
import 'dart:developer' as dev;
import 'QuestionData.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class QuestionView extends StatefulWidget {
  final List questionPos;
  final List question;
  final List correct;
  final List answer;
  int inic;
  int itemcount;

  QuestionView({Key key, this.questionPos, this.question, this.correct, this.answer, this.inic, this.itemcount}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  String viewQuestion;
  String viewCorrect;
  String viewAnswer;
  int posHelper;
  int inicHelper = 0;
  int correctCounter = 0;
  double test = 0;
  bool isLast = false;

  // QuestionData questionData;

  @override
  void initState() {
    inicHelper = 0;
    posHelper = widget.questionPos.length;

    print(widget.itemcount);

    viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.inic));
    viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(widget.inic));

    changeText();
  }

  changeText() {
    if (inicHelper <= 4) {
      print(inicHelper);
      setState(() {
        viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(inicHelper));
        viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(inicHelper));
      });
      if (inicHelper == 4) {
        isLast = true;
        inicHelper--;
      } else {
        inicHelper++;
        if (isLast) {
          test = this.correctCounter / widget.questionPos.length * 100;
          _showDialog();
        }
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // retorna um objeto do tipo Dialog
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 20.0,
            percent: 0.7,
            center: Text('$test'),
            footer: Text('You '),
            progressColor: Colors.green,
          ),
          actions: <Widget>[
            // define os botões na base do dialogo
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
                //limpar contador
                // inicHelper = 0;
                // correctCounter = 0;
                // isLast = false;
                //chamar change text
                // main();
                // initState();
                Phoenix.rebirth(context);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  score(int i) {
    if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(inicHelper))[i]) {
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
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(inicHelper))[0]),
                    onPressed: () {
                      score(0);
                      // _showDialog();
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(inicHelper))[1]),
                    onPressed: () {
                      score(1);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(inicHelper))[2]),
                    onPressed: () {
                      score(2);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(inicHelper))[3]),
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
