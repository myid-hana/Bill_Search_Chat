import 'package:bill_search_chat/container/chat/chat_text_input.dart';
import 'package:bill_search_chat/container/chat/list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bill Search Chat'),
      ),
      body: const Column(
        children: [
          Expanded(
            child: ChatList(),
          ),
          ChatTextInput(),
        ],
      ),
    );
  }
}
