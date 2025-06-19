import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobfit/widgets/common/custom_animated_container.dart';
import 'package:jobfit/widgets/result_container/result_main_container.dart';
import 'package:jobfit/widgets/result_container/result_progress_bar_container.dart';
import 'package:jobfit/widgets/result_container/result_job_links_container.dart';
import 'package:jobfit/widgets/result_container/result_suggested_careers_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnimatedResultSections extends StatefulWidget {
  final String resultType;
  final String emoji;
  final String description;
  final Map<String, int> typeCounts;
  final int totalAnswers;

  const AnimatedResultSections({
    super.key,
    required this.resultType,
    required this.emoji,
    required this.description,
    required this.typeCounts,
    required this.totalAnswers,
  });

  @override
  State<AnimatedResultSections> createState() => _AnimatedResultSectionsState();
}

class _AnimatedResultSectionsState extends State<AnimatedResultSections> {
  int visibleIndex = 0;
  int? _tappedIndex; // New: which section is enlarged
  final PageController _pageController = PageController();
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _startRevealAnimations();
  }

  void _startRevealAnimations() {
    _animationTimer?.cancel();
    _animationTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      // If no section is tapped/enlarged
      if (_tappedIndex == null && mounted) {
        final nextIndex = (visibleIndex + 1) % _sections.length;
        setState(() => visibleIndex = nextIndex);
        _pageController.animateToPage(
          nextIndex,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopRevealAnimations() {
    _animationTimer?.cancel();
  }

  final Duration _fadeDuration = const Duration(milliseconds: 500);

  Widget _buildTappableSection(Widget child, int index) {
    final isTapped = _tappedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (_tappedIndex == index) {
            _tappedIndex = null;
            _startRevealAnimations();
          } else {
            _tappedIndex = index; // enlarge this
            _stopRevealAnimations();
          }
        });
      },
      child: AnimatedScale(
        scale: isTapped ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutBack,
        child: child,
      ),
    );
  }

  List<Widget> get _sections => [
    _buildTappableSection(
      CustomAnimatedContainer(
        isVisible: visibleIndex >= 0,
        duration: _fadeDuration,
        child: ResultMainContainer(
          emoji: widget.emoji,
          resultType: widget.resultType,
          description: widget.description,
        ),
      ),
      0,
    ),
    _buildTappableSection(
      CustomAnimatedContainer(
        isVisible: visibleIndex >= 1,
        duration: _fadeDuration,
        child: ResultProgressBarContainer(
          typeCounts: widget.typeCounts,
          total: widget.totalAnswers,
          topType: widget.resultType,
        ),
      ),
      1,
    ),
    _buildTappableSection(
      CustomAnimatedContainer(
        isVisible: visibleIndex >= 2,
        duration: _fadeDuration,
        child: ResultJobLinksContainer(resultType: widget.resultType),
      ),
      2,
    ),
    _buildTappableSection(
      CustomAnimatedContainer(
        isVisible: visibleIndex >= 3,
        duration: _fadeDuration,
        child: ResultSuggestedCareersContainer(resultType: widget.resultType),
      ),
      3,
    ),
  ];

  @override
  void dispose() {
    _animationTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 380,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _sections.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(child: _sections[index]),
              );
            },
          ),
        ),
        SmoothPageIndicator(
          controller: _pageController,
          count: _sections.length,
          effect: WormEffect(
            dotColor: Colors.grey,
            activeDotColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
