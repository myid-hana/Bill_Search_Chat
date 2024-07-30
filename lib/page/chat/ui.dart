import 'package:bill_search_chat/container/chat/chat_text_input.dart';
import 'package:bill_search_chat/page/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final pageBottom = _scrollController.position.maxScrollExtent;
      _scrollController.animateTo(
        pageBottom,
        curve: Curves.linear,
        duration: const Duration(milliseconds: 300),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final chatWidgetList = ref.watch(chatWidgetListProvider);
    ref.listen(chatWidgetListProvider, (oldState, newState) {
      if (oldState != newState) {
        _scrollToBottom();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Search Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              controller: _scrollController,
              itemCount: chatWidgetList.length,
              itemBuilder: (context, index) {
                return chatWidgetList[index];
              },
            ),
          ),
          const ChatTextInput(),
        ],
      ),
    );
  }
}
