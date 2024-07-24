import 'package:bill_search_chat/components/animation/bounce_widget.dart';
import 'package:flutter/material.dart';

class BounceSpeechBubble extends StatelessWidget {
  final String text;
  final bool isAnswer;
  const BounceSpeechBubble({
    super.key,
    required this.text,
    required this.isAnswer,
  });

  @override
  Widget build(BuildContext context) {
    return BounceWidget(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Align(
          alignment: isAnswer ? Alignment.centerLeft : Alignment.centerRight,
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: isAnswer ? Colors.grey : Colors.blue,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              text,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
