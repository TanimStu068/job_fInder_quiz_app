import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobfit/models/question.dart'; // Make sure this import exists

class QuestionScreenAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final int currentQuestionIndex;
  final List<Question> questions;

  const QuestionScreenAppbar({
    super.key,
    required this.currentQuestionIndex,
    required this.questions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 78, 39, 162),
      elevation: 4,
      centerTitle: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      title: Text(
        'Question ${currentQuestionIndex + 1}/${questions.length}',
        style: GoogleFonts.poppins(
          color: Colors.white.withOpacity(0.9),
          fontSize: 20,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
          shadows: const [
            Shadow(blurRadius: 4, color: Colors.black45, offset: Offset(1, 2)),
          ],
        ),
      ),
      actions: const [
        Padding(
          padding: EdgeInsets.only(right: 16.0),
          child: Icon(Icons.quiz_rounded, size: 28, color: Colors.white70),
        ),
      ],
    );
  }
}
