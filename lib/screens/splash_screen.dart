import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback onSplashFinised;
  const SplashScreen({super.key, required this.onSplashFinised});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late AnimationController _loadingTextController;
  late Animation<double> _loadingTextAnimation;

  @override
  void initState() {
    super.initState();

    //audio player

    //loading text...
    _loadingTextController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    //loading text animation...
    _loadingTextAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _loadingTextController, curve: Curves.easeInOut),
    );

    //Animation setup
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _scaleAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    //Navigate to main screen after delay
    _controller.forward().whenComplete(() {
      Future.delayed(const Duration(seconds: 4), () {
        if (!mounted) return;
        widget.onSplashFinised();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _loadingTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  //option 1
                  Color(0xFF6F42C1),
                  Color.fromARGB(255, 32, 20, 72),
                  // //option 2
                  // Color(0xFF6F42C1), // Rich purple
                  // Color(0xFF4A90E2), // Calm, modern blue
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //Image.asset('assets/images/app_logo.png', height: 120),
                      const SizedBox(height: 24),
                      Text(
                        'Dream Job Finder',
                        style: GoogleFonts.poppins(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              blurRadius: 6.0,
                              color: Colors.black45,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Find your future career 🎯',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white70,
                          letterSpacing: 0.5,
                        ),
                      ),
                      const SizedBox(height: 70),
                      Transform.scale(
                        scale: 1.5,
                        child: CircularProgressIndicator(
                          strokeWidth: 5.0,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.amber,
                          ),
                          backgroundColor: Colors.white24,
                          semanticsLabel: 'Loading',
                        ),
                      ),
                      const SizedBox(height: 16),
                      ScaleTransition(
                        scale: _loadingTextAnimation,
                        child: const Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Positioned(
            bottom: 16,
            right: 16,
            child: Text(
              'v1.0.0',
              style: TextStyle(color: Colors.white30, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
