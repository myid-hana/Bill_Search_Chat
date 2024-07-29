import 'package:flutter/material.dart';

class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<double>> _animations;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();

    _animations = _createOpacityAnimations();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<Animation<double>> _createOpacityAnimations() {
    return List.generate(3, (index) {
      return TweenSequence([
        TweenSequenceItem(
          tween: Tween<double>(begin: 0.2, end: 1.0),
          weight: 1,
        ),
        TweenSequenceItem(
          tween: Tween<double>(begin: 1.0, end: 0.2),
          weight: 1,
        ),
      ]).animate(
        CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            index * 0.33,
            (index + 1) * 0.33,
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          return _buildIndicator(_animations[index]);
        }),
      ),
    );
  }

  Widget _buildIndicator(Animation<double> animation) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(animation.value),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }
}
