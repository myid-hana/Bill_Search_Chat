import 'package:bill_search_chat/container/chat/answer_chat_widget.dart';
import 'package:bill_search_chat/components/chat/bounce_speech_bubble.dart';
import 'package:bill_search_chat/page/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatTextInput extends ConsumerStatefulWidget {
  const ChatTextInput({super.key});

  @override
  ConsumerState<ChatTextInput> createState() => _ChatTextInputState();
}

class _ChatTextInputState extends ConsumerState<ChatTextInput> {
  final TextEditingController _textController = TextEditingController();

  void _onEditingComplete() {
    ref.read(keywordProvider.notifier).state = _textController.text;
    _addChatWidget(_textController.text);
    _textController.clear();
  }

  void _addChatWidget(String keyword) {
    Widget sendChatWidget = BounceSpeechBubble(
      text: keyword,
      isAnswer: false,
    );
    Widget answerChatWidget = AnswerChatWidget(keyword: keyword);

    ref.read(chatWidgetListProvider.notifier).add(sendChatWidget);
    ref.read(chatWidgetListProvider.notifier).add(answerChatWidget);
  }

  @override
  Widget build(BuildContext context) {
    final keyword = ref.watch(keywordProvider);
    final isLoading = ref.watch(getAnswerProvider(keyword)).isLoading;

    return Container(
      height: 100,
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textController,
              decoration:
                  const InputDecoration(labelText: 'Enter a search keyword'),
              onEditingComplete: () {
                if (_textController.text.isNotEmpty && !isLoading) {
                  _onEditingComplete();
                }
              },
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (_textController.text.isNotEmpty && !isLoading) {
                _onEditingComplete();
              }
            },
          ),
        ],
      ),
    );
  }
}
