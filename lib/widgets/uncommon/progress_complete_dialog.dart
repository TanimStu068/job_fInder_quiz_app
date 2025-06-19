import 'dart:ui';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';

class ProgressCompleteDialog extends StatefulWidget {
  final VoidCallback onFinish;
  const ProgressCompleteDialog({super.key, required this.onFinish});

  @override
  State<ProgressCompleteDialog> createState() => _ProgressCompleteDialogState();
}

class _ProgressCompleteDialogState extends State<ProgressCompleteDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  final List<String> _messages = [
    "✅ 100% Complete!",
    "🔍 Analyzing your answers...",
    "⚙️ Creating best profession for you...",
  ];

  int _currentMessageIndex = 0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );
    _controller.forward();

    _playSound();

    _startDialogSequence();
  }

  Future<void> _playSound() async {
    try {
      await _audioPlayer.setAsset('assets/audio/question_complete_sound.mp3');
      await _audioPlayer.play();
    } catch (e) {
      print('Audio error: $e');
    }
  }

  void _startDialogSequence() {
    Timer(const Duration(seconds: 3), () {
      setState(() => _currentMessageIndex = 1);
    });

    Timer(const Duration(seconds: 6), () {
      setState(() => _currentMessageIndex = 2);
    });

    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pop();
      widget.onFinish();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Widget _buildGlowingProgress() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurpleAccent.withOpacity(0.6),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: const CircularProgressIndicator(
        strokeWidth: 6,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Frosted glass background
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(color: Colors.black.withOpacity(0.2)),
        ),
        // The dialog
        Center(
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: AlertDialog(
              backgroundColor: const Color.fromARGB(
                230,
                103,
                64,
                197,
              ), // A slightly lighter, transparent match
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              elevation: 20,
              contentPadding: const EdgeInsets.all(30),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildGlowingProgress(),
                  const SizedBox(height: 25),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      _messages[_currentMessageIndex],
                      key: ValueKey(_messages[_currentMessageIndex]),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
