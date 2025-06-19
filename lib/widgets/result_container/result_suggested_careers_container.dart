import 'package:flutter/material.dart';
import 'package:jobfit/widgets/uncommon/suggested_careers.dart';

class ResultSuggestedCareersContainer extends StatelessWidget {
  final String resultType;

  const ResultSuggestedCareersContainer({super.key, required this.resultType});

  @override
  Widget build(BuildContext context) {
    return SuggestedCareers(resultType: resultType);
  }
}
