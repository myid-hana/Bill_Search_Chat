import 'package:bill_search_chat/components/animation/typing_indicator.dart';
import 'package:bill_search_chat/components/chat/bounce_speech_bubble.dart';
import 'package:bill_search_chat/page/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnswerChatWidget extends ConsumerWidget {
  final String keyword;
  const AnswerChatWidget({
    super.key,
    required this.keyword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAnswerProvider(keyword)).when(
          data: (data) => BounceSpeechBubble(text: data, isAnswer: true),
          error: (error, _) =>
              BounceSpeechBubble(text: error.toString(), isAnswer: true),
          loading: () => const TypingIndicator(),
        );
  }
}
