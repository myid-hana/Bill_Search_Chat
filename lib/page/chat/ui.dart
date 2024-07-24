import 'package:bill_search_chat/components/animation/typing_indicator.dart';
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
    final isAnswering = ref.read(isAnsweringProvider);
    final keyword = _controller.text;

    if (keyword.isNotEmpty && !isAnswering) return;

    ref.read(isAnsweringProvider.notifier).state = true;
    _controller.clear();
    _addChatWidget(keyword);
    ref.read(isAnsweringProvider.notifier).state = false;
  }

  void _addChatWidget(String keyword) {
    const typingIndicator = TypingIndicator();
    late Widget sendChatWidget = BounceSpeechBubble(
      text: keyword,
      isAnswer: false,
    );

    ref.read(chatWidgetListProvider.notifier).add(sendChatWidget);
    ref.read(chatWidgetListProvider.notifier).add(typingIndicator);

    //TODO api 연결 함수 추가
    const result = '';
    late Widget answerChatWidget = const BounceSpeechBubble(
      text: result,
      isAnswer: true,
    );

    ref.read(chatWidgetListProvider.notifier).remove(typingIndicator);
    ref.read(chatWidgetListProvider.notifier).add(answerChatWidget);
  }

  @override
  Widget build(BuildContext context) {
    final chatWidgetList = ref.watch(chatWidgetListProvider);

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
                    onEditingComplete: () => _onEditingComplete(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () => _onEditingComplete(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
