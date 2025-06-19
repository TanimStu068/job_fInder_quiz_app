import 'package:flutter/material.dart';

class CustomAnimatedContainer extends StatelessWidget {
  final Widget child;
  final bool isVisible;
  final Duration duration;
  final Curve curve;
  final Offset offset;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color backgroundColor;
  const CustomAnimatedContainer({
    super.key,
    required this.child,
    required this.isVisible,
    this.duration = const Duration(milliseconds: 700),
    this.curve = Curves.easeOut,
    this.offset = const Offset(1.5, 0), // From right to left
    this.margin = const EdgeInsets.symmetric(vertical: 12),
    this.padding = const EdgeInsets.all(24),
    this.backgroundColor = const Color(0xFF6A4FB3),
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      offset: isVisible ? Offset.zero : offset,
      duration: duration,
      curve: curve,
      child: Container(
        height: 380,
        width: 280,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [
            BoxShadow(
              color: Colors.black45,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
