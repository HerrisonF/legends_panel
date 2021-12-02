import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DotsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return JumpingDotsProgressIndicator(
      fontSize: 22,
      color: Colors.white,
    );
  }
}
