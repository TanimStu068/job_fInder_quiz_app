import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroCustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

  const IntroCustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color topColor = isSelected ? Colors.amber : const Color(0xFFF5F5F5);
    final Color sideShadow = const Color.fromARGB(
      255,
      165,
      165,
      165,
    ); // Right/bottom edge
    final Color topHighlight = const Color.fromARGB(
      255,
      147,
      147,
      147,
    ); // Top/left edge

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        height: 53,
        decoration: BoxDecoration(
          color: topColor,
          borderRadius: BorderRadius.circular(22),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [Colors.amber.shade300, Colors.amber.shade600]
                : [topColor, sideShadow],
          ),
          boxShadow: [
            BoxShadow(
              color: sideShadow,
              offset: const Offset(5, 5),
              blurRadius: 2,
            ),
            BoxShadow(
              color: topHighlight,
              offset: const Offset(-2, -2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.black : const Color(0xFF333333),
            ),
          ),
        ),
      ),
    );
  }
}
