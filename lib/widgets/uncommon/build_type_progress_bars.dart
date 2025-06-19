import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTypeProgressBars extends StatelessWidget {
  final Map<String, int> typeCounts;
  final int total;
  final String topType;

  BuildTypeProgressBars({
    super.key,
    required this.typeCounts,
    required this.total,
    required this.topType,
  });

  final Map<String, String> typeEmoji = {
    'AI Engineer': '🧠',
    'Full-Stack Developer': '🧑‍💻',
    'Mobile App Developer': '📱',
    'DevOps Engineer': '🛠️',
    'Cybersecurity Specialist': '🛡️',
  };

  final Map<String, Color> typeColors = {
    'AI Engineer': Colors.indigoAccent, // Futuristic & intelligent
    'Full-Stack Developer': Colors.blueAccent, // Tech-savvy & dependable
    'Mobile App Developer': Colors.tealAccent, // Creative & modern
    'DevOps Engineer':
        Colors.deepPurpleAccent, // Stable & infrastructure-oriented
    'Cybersecurity Specialist':
        Colors.redAccent, // Alert, security, and urgency
  };

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Center(
              child: Icon(
                Icons.search, // or any other meaningful icon
                color: Colors.white,
                size: 60,
              ),
            ),
            SizedBox(height: 15),
            Text(
              'Discover Your Strengths', // <-- Your heading text here
              style: GoogleFonts.poppins(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            ...typeEmoji.keys.map((type) {
              final count = typeCounts[type] ?? 0;
              final percent = total == 0 ? 0.0 : count / total;
              final emoji = typeEmoji[type] ?? '';
              final color = typeColors[type] ?? Colors.white54;

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            "$emoji $type: ${count}x (${(percent * 100).toStringAsFixed(0)}%)",
                            style: GoogleFonts.poppins(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        if (type == topType) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                        ],
                      ],
                    ),
                    const SizedBox(height: 6),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: percent),
                        duration: const Duration(milliseconds: 900),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, _) => LinearProgressIndicator(
                          value: value,
                          backgroundColor: Colors.white10,
                          valueColor: AlwaysStoppedAnimation(
                            type == topType ? Colors.amber : color,
                          ),
                          minHeight: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
