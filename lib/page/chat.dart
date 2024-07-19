import 'package:bill_search_chat/components/animation/typing_indicator.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  final List<Widget> chatWidgetList = [];
  final TextEditingController _controller = TextEditingController();
  bool isAnswering = false;

  void _makeChatWidget(String submitValue) {
    isAnswering = true;
    setState(() {
      chatWidgetList.add(
        BounceWidget(child: sendChatWidget(submitValue)),
      );
      chatWidgetList.add(const TypingIndicator());
    });

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        chatWidgetList.removeLast();
        chatWidgetList.add(
          BounceWidget(child: responseChatWidget(submitValue)),
        );
      });
      isAnswering = false;
    });
  }

  void _onEditingComplete() {
    if (_controller.text.isNotEmpty && !isAnswering) {
      _makeChatWidget(_controller.text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bill Search Chat')),
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

class BounceWidget extends StatefulWidget {
  final Widget child;
  const BounceWidget({super.key, required this.child});

  @override
  State<BounceWidget> createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animation = Tween<double>(begin: 0, end: 20)
        .chain(CurveTween(curve: Curves.bounceOut))
        .animate(_animationController);
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

Widget sendChatWidget(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget responseChatWidget(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
  );
}
