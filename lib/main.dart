import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:zallpy_quiz/QuestionView.dart';
import 'QuestionData.dart';
import 'Question.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:math';
import 'package:flutter_phoenix/flutter_phoenix.dart';

void main() {
  runApp(Phoenix(child: Zallpy()));
}

Future<QuestionData> fetchQuiz() async {
  final url = '200.98.73.89';
  // final endpoint = '/vini/zallpy_data.json';
  final endpoint = '/vini/zallpy_quiz.json';
  final uri = Uri.http(url, endpoint);

  final response = await http.get(uri);

  var jsonResponse = convert.jsonDecode(response.body);

  Map<String, dynamic> map = convert.jsonDecode(response.body);

  print(response.statusCode);
  print(map);

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    return QuestionData.fromJson(map);
  } else {
    print('Request failed with status: ${response.statusCode}.');
  }
}

class Zallpy extends StatelessWidget {
  // This widget is the root of your application.
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
      body: Center(
        child: FutureBuilder<QuestionData>(
          future: futureQuiz,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            print(snapshot);
            if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
              // int c = 0;
              // print('mds $c');
              // if (snapshot.connectionState == ConnectionState.done) {
              //   c++;
              // }
              // print('mds que merda $c');
              List<String> questions = [];
              List<String> correct = [];
              List answer = [];
              List data = [];
              List<int> questionRandomizer = [];
              Random random = new Random();

              while (questionRandomizer.length <= 4) {
                int random_number = random.nextInt(5);
                if (!questionRandomizer.contains(random_number)) {
                  questionRandomizer.add(random_number);
                }
              }

              print(questionRandomizer.length);
              print('aaaa - - - $questionRandomizer');

              // print(snapshot.data.results.elementAt(0).answers.length);
              var tam = snapshot.data.results.length;
              // print(tam);

              // for (var i = 0; i < tam; i++) {
              //   for (var j = 0; j < snapshot.data.results.elementAt(0).answers.length; j++) {
              //     var dataFields = {
              //       'question': snapshot.data.results.elementAt(i).question,
              //       'correct': snapshot.data.results.elementAt(i).correct,
              //       'answer': snapshot.data.results.elementAt(j).answers,
              //     };
              //     data.add(dataFields);
              //   }
              // }

              for (var i = 0; i < tam; i++) {
                questions.add(snapshot.data.results.elementAt(i).question);
                correct.add(snapshot.data.results.elementAt(i).correct);
                answer.add(snapshot.data.results.elementAt(i).answers);
              }

              return SafeArea(
                child: QuestionView(
                  questionPos: questionRandomizer,
                  // question: data,
                  itemcount: questionRandomizer.length,
                  question: questions,
                  correct: correct,
                  answer: answer,
                  inic: 0,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'No Data',
                  textAlign: TextAlign.center,
                ),
              );
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
