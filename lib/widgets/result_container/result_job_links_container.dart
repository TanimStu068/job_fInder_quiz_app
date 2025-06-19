import 'package:flutter/material.dart';
import 'package:jobfit/widgets/uncommon/job_links.dart';

class ResultJobLinksContainer extends StatelessWidget {
  final String resultType;
  const ResultJobLinksContainer({super.key, required this.resultType});

  @override
  Widget build(BuildContext context) {
    return JobLinks(type: resultType);
  }
}
