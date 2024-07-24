import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'state.g.dart';

final isAnsweringProvider = StateProvider<bool>((ref) => false);

@riverpod
class ChatWidgetList extends _$ChatWidgetList {
  @override
  List<Widget> build() {
    return [];
  }

  void add(Widget widget) {
    state.add(widget);
  }

  void remove(Widget widget) {
    state.remove(widget);
  }
}
