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
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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

  void _scrollToBottom() {
    final pageBottom = _scrollController.position.maxScrollExtent;
    _scrollController.animateTo(
      pageBottom,
      curve: Curves.linear,
      duration: const Duration(milliseconds: 500),
    );
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
              controller: _scrollController,
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
                    controller: _textController,
                    decoration: const InputDecoration(
                        labelText: 'Enter a search keyword'),
                    onEditingComplete: () {
                      _scrollToBottom();
                      if (_textController.text.isNotEmpty && !isLoading) {
                        _onEditingComplete();
                      }
                    },
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    _scrollToBottom();
                    if (_textController.text.isNotEmpty && !isLoading) {
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
