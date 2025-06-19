import 'package:flutter/material.dart';
import 'package:jobfit/screens/introduction_screens.dart';
import 'package:jobfit/screens/questions_screen.dart';
import 'package:jobfit/screens/splash_screen.dart';

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int current_index = 0;
  List<String> choosenAnswers = [];

  void onSplashchanged() {
    setState(() {
      current_index = 1;
    });
  }

  void onIntrochanged() {
    setState(() {
      current_index = 2;
    });
  }

  @override
  Widget build(context) {
    Widget current_screen = SplashScreen(onSplashFinised: onSplashchanged);

    if (current_index == 1) {
      current_screen = IntroductionScreens(onFinished: onIntrochanged);
    }
    if (current_index == 2) {
      current_screen = QuestionsScreen();
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dream Job Finder',
      home: Scaffold(body: current_screen),
    );
  }
}
