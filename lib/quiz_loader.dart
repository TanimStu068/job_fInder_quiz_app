import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:jobfit/models/question.dart';

Future<List<Question>> loadQuizQuestions() async {
  final String jsonString = await rootBundle.loadString(
    'assets/data/quiz.json',
  );
  final List<dynamic> jsonData = json.decode(jsonString);
  return jsonData.map((data) => Question.fromJson(data)).toList();
}

Future<int> getTotalQuestionCount() async {
  final List<Question> questions = await loadQuizQuestions();
  return questions.length;
}
