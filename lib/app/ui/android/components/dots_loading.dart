import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';

class DotsLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: JumpingDotsProgressIndicator(
        fontSize: 30,
        color: Theme.of(context).primaryColor,
      ),
    );
  }
}
