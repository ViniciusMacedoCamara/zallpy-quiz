class Question {
  int responseCode;
  List<Results> results;

  Question({this.responseCode, this.results});

  Question.fromJson(Map<String, dynamic> json) {
    responseCode = json['response_code'];
    if (json['results'] != null) {
      results = new List<Results>();
      json['results'].forEach((v) {
        results.add(new Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['response_code'] = this.responseCode;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String question;
  int correct;
  List<String> answers;

  Results({this.question, this.correct, this.answers});

  Results.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    correct = json['correct'];
    answers = json['answers'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['correct'] = this.correct;
    data['answers'] = this.answers;
    return data;
  }
}
