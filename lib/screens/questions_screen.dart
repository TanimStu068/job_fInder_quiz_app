import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jobfit/screens/result_screen.dart';
import 'package:jobfit/widgets/common/custom_botton.dart';
import 'package:jobfit/widgets/uncommon/progress_complete_dialog.dart';
import 'package:jobfit/widgets/uncommon/question_screen_appbar.dart';
import '../models/question.dart';
import 'package:jobfit/quiz_loader.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:just_audio/just_audio.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  late final AudioPlayer _textSoundPlayer;

  // Track which questions have played the typing sound to avoid repeats
  final Set<int> _playedTypingSounds = {};

  List<Question> _questions = [];
  List<String> _selectedAnswerTypes = [];

  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  bool _showOptions = false;

  @override
  void initState() {
    super.initState();
    loadQuiz();
    _textSoundPlayer = AudioPlayer();
  }

  Future<void> _playSound(AudioPlayer player, String assetPath) async {
    try {
      await player.setAsset(assetPath);
      await player.play();
    } catch (e) {
      if (kDebugMode) print('Error playing sound: $e');
    }
  }

  Future<void> loadQuiz() async {
    final questions = await loadQuizQuestions();
    setState(() {
      _questions = questions;
    });
    // Start typing sound immediately for the first question
    _playedTypingSounds.add(0);
    final charCount = questions[0].question.length;
    const int speedPerChar = 80;
    final int totalAnimationTimeMs = charCount * speedPerChar;

    _playSound(_textSoundPlayer, 'assets/audio/typing.mp3');
    Future.delayed(Duration(milliseconds: totalAnimationTimeMs), () {
      _textSoundPlayer.stop();
    });
  }

  @override
  void dispose() {
    _textSoundPlayer.dispose();
    super.dispose();
  }

  void _nextQuestion(String selectedType) {
    _selectedAnswerTypes.add(selectedType);

    if (_currentQuestionIndex < _questions.length - 1) {
      final nextIndex = _currentQuestionIndex + 1;
      final charCount = _questions[nextIndex].question.length;
      const int speedPerChar = 80;
      final int totalAnimationTimeMs = charCount * speedPerChar;

      _playedTypingSounds.add(nextIndex);
      _playSound(_textSoundPlayer, 'assets/audio/typing.mp3');
      Future.delayed(Duration(milliseconds: totalAnimationTimeMs), () {
        _textSoundPlayer.stop();
      });

      setState(() {
        _currentQuestionIndex = nextIndex;
        _selectedAnswerIndex = null;
        _showOptions = false;
      });
    } else {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => ProgressCompleteDialog(
          onFinish: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ResultScreen(selectedAnswerTypes: _selectedAnswerTypes),
              ),
            );
          },
        ),
      );
    }
  }

  @override
  Widget build(context) {
    if (_questions.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final double progress = (_currentQuestionIndex) / _questions.length;
    final int percentage = (progress * 100).round();

    // Calculate animation duration to sync sound
    final int charCount = currentQuestion.question.length;
    const int speedPerChar = 80; // ms per char
    final int totalAnimationTimeMs = charCount * speedPerChar;

    return Scaffold(
      backgroundColor: const Color(0xFF512D9C),
      appBar: QuestionScreenAppbar(
        currentQuestionIndex: _currentQuestionIndex,
        questions: _questions,
      ),

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF512D9C), Color.fromARGB(255, 64, 29, 105)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                '$percentage% completed',
                style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white12,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFB39DDB),
                  ),
                  minHeight: 10,
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Center(
                  child: AnimatedTextKit(
                    key: ValueKey('question_text$_currentQuestionIndex'),
                    animatedTexts: [
                      TyperAnimatedText(
                        currentQuestion.question,
                        textStyle: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                        speed: const Duration(milliseconds: speedPerChar),
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 1000),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
                    onFinished: () {
                      setState(() {
                        _showOptions = true;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 20),
              if (_showOptions)
                ...currentQuestion.answers.asMap().entries.map((entry) {
                  final index = entry.key;
                  final answer = entry.value;
                  final isSelected = _selectedAnswerIndex == index;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TweenAnimationBuilder<Offset>(
                      key: ValueKey('q$_currentQuestionIndex-a$index'),
                      tween: Tween<Offset>(
                        begin: const Offset(-1.5, 0),
                        end: Offset.zero,
                      ),
                      duration: Duration(milliseconds: 1200 + index * 250),
                      curve: Curves.easeOutBack,
                      builder: (context, offset, child) {
                        // Play option appear sound only once per option

                        return Transform.translate(
                          offset: Offset(
                            offset.dx * MediaQuery.of(context).size.width,
                            0,
                          ),
                          child: child,
                        );
                      },
                      child: CustomBotton(
                        onTap: () {
                          setState(() {
                            _selectedAnswerIndex = index;
                          });
                          Future.delayed(const Duration(milliseconds: 300), () {
                            _nextQuestion(answer.type);
                          });
                        },
                        text: answer.text,
                        isSelected: isSelected,
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
