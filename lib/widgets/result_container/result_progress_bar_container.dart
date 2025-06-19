import 'package:flutter/material.dart';
import 'package:jobfit/widgets/uncommon/build_type_progress_bars.dart';

class ResultProgressBarContainer extends StatelessWidget {
  final Map<String, int> typeCounts;
  final int total;
  final String topType;

  const ResultProgressBarContainer({
    super.key,
    required this.typeCounts,
    required this.total,
    required this.topType,
  });

  @override
  Widget build(BuildContext context) {
    return BuildTypeProgressBars(
      typeCounts: typeCounts,
      total: total,
      topType: topType,
    );
  }
}
