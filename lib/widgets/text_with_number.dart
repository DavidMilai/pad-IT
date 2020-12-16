import 'package:flutter/material.dart';

class TextWithNumber extends StatelessWidget {
  final Color numberColor, textColor;
  final String text, number;
  final Function onTap;
  TextWithNumber(
      {this.onTap, this.numberColor, this.textColor, this.number, this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: <TextSpan>[
            TextSpan(
                text: '$number\n',
                style: TextStyle(
                    color: numberColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 18)),
            TextSpan(
                text: '$text',
                style: TextStyle(
                    color: textColor == null ? Colors.black : textColor)),
          ],
        ),
      ),
    );
  }
}
