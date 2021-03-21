import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';

class QuestionView extends StatefulWidget {
  final List questionPos;
  final List question;
  final List correct;
  final List answer;
  int init;
  int itemCount;

  QuestionView({Key key, this.questionPos, this.question, this.correct, this.answer, this.init, this.itemCount}) : super(key: key);
  @override
  _QuestionViewState createState() => _QuestionViewState();
}

class _QuestionViewState extends State<QuestionView> {
  String viewQuestion;
  String viewCorrect;
  String viewAnswer;
  int posHelper;
  int initHelper = 0;
  int correctCounter = 0;
  double percentage = 0;
  bool isLast = false;

  @override
  void initState() {
    initHelper = 0;
    posHelper = widget.questionPos.length;
    viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(widget.init));
    viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(widget.init));
    changeText();
  }

  changeText() {
    if (initHelper <= 4) {
      print(initHelper);
      setState(() {
        viewQuestion = widget.question.elementAt(widget.questionPos.elementAt(initHelper));
        viewCorrect = widget.correct.elementAt(widget.questionPos.elementAt(initHelper));
      });
      if (initHelper == 4) {
        isLast = true;
        initHelper--;
      } else {
        initHelper++;
        if (isLast) {
          percentage = this.correctCounter / widget.questionPos.length * 100;
          _showDialog();
        }
      }
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Completed'),
          content: CircularPercentIndicator(
            radius: 150.0,
            lineWidth: 20.0,
            percent: correctCounter / widget.questionPos.length,
            center: Text('$percentage'),
            footer: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
              child: Text('You got it right $correctCounter out of $posHelper questions!'),
            ),
            progressColor: Colors.green,
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Play Again'),
              onPressed: () {
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
    if (viewCorrect == widget.answer.elementAt(widget.questionPos.elementAt(initHelper))[i]) {
      this.correctCounter++;
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
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(initHelper))[0]),
                    onPressed: () {
                      score(0);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(initHelper))[1]),
                    onPressed: () {
                      score(1);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(initHelper))[2]),
                    onPressed: () {
                      score(2);
                    },
                  ),
                  ElevatedButton(
                    child: Text(widget.answer.elementAt(widget.questionPos.elementAt(initHelper))[3]),
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
