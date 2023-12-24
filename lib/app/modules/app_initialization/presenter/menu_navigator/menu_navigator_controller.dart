import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MenuNavigatorController {

  ValueNotifier<int> currentPageIndex = ValueNotifier(0);

  void navigateToPage(BuildContext context, int index, String location) {
    if (index == currentPageIndex.value) return;

    GoRouter router = GoRouter.of(context);

    currentPageIndex.value = index;

    router.go(location);
  }
}