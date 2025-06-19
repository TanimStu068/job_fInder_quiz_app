import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobfit/screens/animated_result_sections.dart';
import 'package:jobfit/screens/questions_screen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:just_audio/just_audio.dart';

class ResultScreen extends StatefulWidget {
  final List<String> selectedAnswerTypes;

  const ResultScreen({super.key, required this.selectedAnswerTypes});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  late ConfettiController _confettiController;
  late final AudioPlayer _audioPlayer;

  final Map<String, String> typeDescription = {
    'AI Engineer': 'You love data, models, and making machines think 🤖',
    'Full-Stack Developer':
        'You build from front to back like a true tech ninja 💻',
    'Mobile App Developer':
        'You craft sleek apps that live in everyone’s pocket 📱',
    'DevOps Engineer':
        'You automate everything and keep systems running smooth ⚙️',
    'Cybersecurity Specialist':
        'You guard the digital world like a silent tech hero 🔐',
  };

  final Map<String, String> typeEmoji = {
    'AI Engineer': '🤖',
    'Full-Stack Developer': '💻',
    'Mobile App Developer': '📱',
    'DevOps Engineer': '⚙️',
    'Cybersecurity Specialist': '🔐',
  };

  @override
  void initState() {
    super.initState();

    _audioPlayer = AudioPlayer();
    _playSound();

    _confettiController = ConfettiController(
      duration: const Duration(seconds: 3),
    );
    _confettiController.play();
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.setAsset('assets/audio/result_music.mp3');
      _audioPlayer.play();
    } catch (e) {
      print("Audio playback error: $e");
    }
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> typeCounts = {};
    for (var type in widget.selectedAnswerTypes) {
      typeCounts[type] = (typeCounts[type] ?? 0) + 1;
    }

    String resultType = '';
    int maxCount = 0;
    typeCounts.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        resultType = type;
      }
    });

    String description =
        typeDescription[resultType] ?? 'You have a special mix of skills!';
    String emoji = typeEmoji[resultType] ?? '🌟';

    return Scaffold(
      backgroundColor: const Color(0xFF512D9C),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF512D9C), Color.fromARGB(255, 75, 34, 122)],
          ),
        ),
        child: SafeArea(
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 36,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight:
                          MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top -
                          MediaQuery.of(context).padding.bottom,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 20),
                          Text(
                            "Your Quiz Result",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              color: Colors.white70,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 30),

                          AnimatedResultSections(
                            resultType: resultType,
                            emoji: emoji,
                            description: description,
                            typeCounts: typeCounts,
                            totalAnswers: widget.selectedAnswerTypes.length,
                          ),

                          const SizedBox(height: 32),
                          // replaced Spacer
                          ElevatedButton.icon(
                            onPressed: () async {
                              final shouldRestart = await showDialog<bool>(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const Text('Restart Quiz'),
                                  content: const Text(
                                    'Are you sure you want to restart the quiz?',
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, false),
                                      child: const Text('No'),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.pop(context, true),
                                      child: const Text('Yes'),
                                    ),
                                  ],
                                ),
                              );
                              if (shouldRestart == true) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const QuestionsScreen(),
                                  ),
                                );
                              }
                            },
                            icon: const Icon(Icons.replay_rounded),
                            label: const Text("Retake Quiz"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple.shade300,
                              foregroundColor: Colors.white,
                              textStyle: GoogleFonts.poppins(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: () {
                              String resultType = '';
                              int maxCount = 0;

                              final typeCounts = <String, int>{};
                              for (var type in widget.selectedAnswerTypes) {
                                typeCounts[type] = (typeCounts[type] ?? 0) + 1;
                              }

                              typeCounts.forEach((type, count) {
                                if (count > maxCount) {
                                  maxCount = count;
                                  resultType = type;
                                }
                              });

                              final emoji = typeEmoji[resultType] ?? '🌟';
                              final description =
                                  typeDescription[resultType] ??
                                  'You have a unique skillset!';
                              final shareText =
                                  "🎯 My Dream Job Result: $emoji $resultType\n$description\n\nFind yours with this fun quiz! 🚀";

                              Share.share(shareText);
                            },
                            icon: const Icon(
                              Icons.share_rounded,
                              color: Colors.white70,
                            ),
                            label: const Text("Share Result"),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Color(0xFFBFAEFF)),
                              textStyle: GoogleFonts.poppins(fontSize: 16),
                              padding: const EdgeInsets.symmetric(
                                vertical: 14,
                                horizontal: 24,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: ConfettiWidget(
                  confettiController: _confettiController,
                  blastDirectionality: BlastDirectionality.explosive,
                  shouldLoop: false,
                  colors: const [
                    Colors.purple,
                    Colors.blue,
                    Colors.pink,
                    Colors.white,
                    Colors.deepPurple,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
