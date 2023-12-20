import 'package:flutter/material.dart';

class HeaderScreenInformation extends StatelessWidget {
  final String title;
  final double bottomSpace;
  final double topSpace;

  HeaderScreenInformation({
    Key? key,
    required this.title,
    required this.bottomSpace,
    required this.topSpace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        margin: EdgeInsets.only(
            left: 10,
            right: 10,
            top: topSpace,
            bottom: bottomSpace),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
