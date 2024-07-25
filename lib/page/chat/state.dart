import 'package:bill_search_chat/service/chat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

final keywordProvider = StateProvider<String>((ref) => "");

final getAnswerProvider =
    FutureProvider.autoDispose.family<String, String>((ref, keyword) async {
  final service = ChatService();
  return await service.getAnswer(keyword);
});

@riverpod
class ChatWidgetList extends _$ChatWidgetList {
  @override
  List<Widget> build() {
    return [];
  }

  void add(Widget widget) {
    state.add(widget);
    ref.notifyListeners();
  }
}
