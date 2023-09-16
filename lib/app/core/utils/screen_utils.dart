import 'package:flutter/material.dart';

abstract class ScreenUtils {

  static const int NEXUS_ONE_SCREEN_WIDTH = 480;

  static screenWidthSizeIsBiggerThanNexusOne() {
    return WidgetsBinding.instance.window.physicalSize.width >
        NEXUS_ONE_SCREEN_WIDTH;
  }

}