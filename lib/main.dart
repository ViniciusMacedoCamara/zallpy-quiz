import 'package:flutter/material.dart';
import 'package:zallpy_quiz/view/NetworkErrorView.dart';
import 'file:///C:/Users/VMC/AndroidStudioProjects/zallpy_quiz/lib/view/QuestionView.dart';
import 'model/QuestionData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(
    Phoenix(
      child: Zallpy(),
    ),
  );
}

Future<QuestionData> fetchQuiz() async {
  final url = '200.98.73.89'; // Check Readme file
  final endpoint = '/vini/zallpy_quiz.json'; // Check Readme file
  final uri = Uri.http(url, endpoint);

  final response = await http.get(uri);

  Map<String, dynamic> map = convert.jsonDecode(response.body);

  if (response.statusCode == 200) {
    return QuestionData.fromJson(map);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

class Zallpy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  Future futureQuiz;

  @override
  void initState() {
    super.initState();
    futureQuiz = fetchQuiz();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff262b41),
      body: Center(
        child: FutureBuilder<QuestionData>(
          future: futureQuiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              List<String> questions = [];
              List<String> correct = [];
              List answer = [];
              List<int> questionRandomizer = [];
              var tam = snapshot.data.results.length;
              Random random = new Random();

              while (questionRandomizer.length <= 4) {
                int randomNumber = random.nextInt(5);
                if (!questionRandomizer.contains(randomNumber)) {
                  questionRandomizer.add(randomNumber);
                }
              }

              for (var i = 0; i < tam; i++) {
                questions.add(snapshot.data.results.elementAt(i).question);
                correct.add(snapshot.data.results.elementAt(i).correct);
                answer.add(snapshot.data.results.elementAt(i).answers);
              }

              return SafeArea(
                child: QuestionView(
                  questionPos: questionRandomizer,
                  itemCount: questionRandomizer.length,
                  question: questions,
                  correct: correct,
                  answer: answer,
                  init: 0,
                ),
              );
            } else if (snapshot.hasError) {
              return NetworkErrorView();
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
