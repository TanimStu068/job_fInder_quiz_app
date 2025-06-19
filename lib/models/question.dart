import 'dart:math';

class Question {
  final String question;
  final List<Answer> answers;

  Question({required this.question, required this.answers});

  factory Question.fromJson(Map<String, dynamic> json) {
    final answers = (json['answers'] as List)
        .map((answer) => Answer.fromJson(answer))
        .toList();
    answers.shuffle(Random());

    return Question(question: json['question'], answers: answers);
  }
}

class Answer {
  final String text;
  final String type;

  Answer({required this.text, required this.type});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(text: json['text'], type: json['type']);
  }
}
