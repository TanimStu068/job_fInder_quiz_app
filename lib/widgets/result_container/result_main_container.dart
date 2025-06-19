import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultMainContainer extends StatelessWidget {
  final String resultType;
  final String emoji;
  final String description;

  const ResultMainContainer({
    super.key,
    required this.resultType,
    required this.emoji,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
                MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'You are a',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(emoji, style: const TextStyle(fontSize: 48)),
                const SizedBox(height: 10),
                Text(
                  resultType,
                  style: GoogleFonts.poppins(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
