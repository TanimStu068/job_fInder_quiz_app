import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:jobfit/widgets/common/intro_custom_button.dart';

class IntroductionScreens extends StatefulWidget {
  final VoidCallback onFinished;
  const IntroductionScreens({super.key, required this.onFinished});

  @override
  State<IntroductionScreens> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreens> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  Timer? _autoPageTimer;

  final List<Map<String, String>> _pages = [
    {
      'title': 'What to Expect?',
      'subtitle':
          '10 quick questions to reveal your tech strengths & passions, with fun emojis & easy choices.',
      'image': 'assets/images/new_intro1.png',
    },
    {
      'title': 'Explore Diverse Tech Roles',
      'subtitle':
          'From AI Engineer to Cybersecurity Specialist — find out which role suits you best!',
      'image': 'assets/images/final_new_intro2.png',
    },
    {
      'title': 'Your Dream Job Awaits!',
      'subtitle':
          'Get a personalized tech career match with detailed insights and tips just for you.',
      'image': 'assets/images/new_intro3.png',
    },
    {
      'title': 'See Your Strengths Clearly',
      'subtitle':
          'Visualize your skills and interests with colorful progress bars and fun emojis.',
      'image': 'assets/images/new_intro4.png',
    },
    {
      'title': 'Discover Related Career Paths',
      'subtitle':
          'Get a list of top roles that match your strengths — tap any role to learn more!',
      'image': 'assets/images/new_intro5.png',
    },
    {
      'title': 'Get Smart Career Tips',
      'subtitle':
          'Access tips tailored to your personality type and tech strengths to guide your journey.',
      'image': 'assets/images/new_intro6.png',
    },
    {
      'title': 'Step Into Your Future',
      'subtitle':
          'Explore real job opportunities tailored to your career type — direct links to top job boards.',
      'image': 'assets/images/new_intro7.png',
    },
    {
      'title': 'Tap to Learn More!',
      'subtitle':
          'After the quiz, tap any career result to see skills you need & salary info — all in a sleek popup.',
      'image': 'assets/images/new_intro8.png',
    },
    {
      'title': 'Why It’s Fun?',
      'subtitle':
          'Engaging questions, smooth animations, and a bit of tech magic to keep you hooked!',
      'image': 'assets/images/new_intro9.png',
    },
  ];

  void _nextPage() {
    if (_currentIndex < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _autoPageTimer?.cancel();
      widget.onFinished();
    }
  }

  void _onPageChanged(int index) {
    setState(() => _currentIndex = index);

    _autoPageTimer?.cancel();

    if (index < _pages.length - 1) {
      _autoPageTimer = Timer(const Duration(seconds: 6), _nextPage);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      _autoPageTimer = Timer(const Duration(seconds: 6), _nextPage);
    });
  }

  @override
  void dispose() {
    _autoPageTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color dotColor = Color(0xFFBDA7F1); // Soft Lavender

    return Scaffold(
      // backgroundColor: primaryColor,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF512D9C), Color.fromARGB(255, 75, 34, 122)],
          ),
        ),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemCount: _pages.length,
              itemBuilder: (context, index) {
                final page = _pages[index];
                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(page['image']!, height: 280),
                      const SizedBox(height: 40),
                      AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            page['title']!,
                            textStyle: GoogleFonts.poppins(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            speed: const Duration(milliseconds: 80),
                          ),
                        ],
                        totalRepeatCount: 1,
                        pause: const Duration(milliseconds: 1000),
                        displayFullTextOnTap: true,
                        stopPauseOnTap: true,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        page['subtitle']!,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            if (_currentIndex > 0)
              Positioned(
                top: 50,
                left: 20,
                child: GestureDetector(
                  onTap: () => _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF7048E8), Color(0xFFB37DF0)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          offset: const Offset(2, 4),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            Positioned(
              bottom: 90,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (index) {
                  bool isActive = _currentIndex == index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 10,
                    width: isActive ? 24 : 10,
                    decoration: BoxDecoration(
                      color: isActive
                          ? const Color.fromARGB(255, 248, 247, 250)
                          : dotColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  );
                }),
              ),
            ),
            //dots
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: () {
                  _autoPageTimer?.cancel();
                  widget.onFinished();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                  // backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                child: Text(
                  'Skip',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),

            // bottom button
            Positioned(
              bottom: 20,
              right: 27,
              left: 27,
              child: Container(
                height: 53,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: IntroCustomButton(
                  onTap: () {
                    _autoPageTimer?.cancel();
                    _nextPage();
                  },
                  text: _currentIndex == _pages.length - 1
                      ? 'Start Quiz'
                      : 'Next',
                  isSelected: false,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
