import 'package:bill_search_chat/page/chat/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatList extends ConsumerStatefulWidget {
  const ChatList({super.key});

  @override
  ConsumerState<ChatList> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
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

    return ListView.builder(
      reverse: true,
      controller: _scrollController,
      itemCount: chatWidgetList.length,
      itemBuilder: (context, index) {
        return chatWidgetList[index];
      },
    );
  }
}
