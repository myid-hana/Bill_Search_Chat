import 'package:bill_search_chat/components/chat/answer_chat_widget.dart';
import 'package:bill_search_chat/components/chat/bounce_speech_bubble.dart';
import 'package:bill_search_chat/page/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();

  void _onEditingComplete() {
    ref.read(keywordProvider.notifier).state = _controller.text;
    _addChatWidget(_controller.text);
    _controller.clear();
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
    final chatWidgetList = ref.watch(chatWidgetListProvider);
    final keyword = ref.watch(keywordProvider);
    final isLoading = ref.watch(getAnswerProvider(keyword)).isLoading;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Search Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: chatWidgetList.length,
              itemBuilder: (context, index) {
                return chatWidgetList[index];
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                        labelText: 'Enter a search keyword'),
                    onEditingComplete: () {
                      if (_controller.text.isNotEmpty && !isLoading) {
                        _onEditingComplete();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty && !isLoading) {
                      _onEditingComplete();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
