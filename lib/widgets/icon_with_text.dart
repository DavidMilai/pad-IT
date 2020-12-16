import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Function onTap;
  IconWithText({this.text, this.onTap, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 40,
            color: color,
          ),
          Text(text)
        ],
      ),
    );
  }
}
