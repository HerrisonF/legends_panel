import 'package:flutter/material.dart';

class MenuTabIconWidget extends StatelessWidget {
  final Color activeColor;
  final IconData icon;
  final Function onTapMenuItem;

  MenuTabIconWidget({
    Key? key,
    required this.activeColor,
    required this.icon,
    required this.onTapMenuItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 41,
        child: Material(
          type: MaterialType.transparency,
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: InkWell(
              onTap: () => onTapMenuItem(),
              child: Icon(
                icon,
                color: activeColor,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
