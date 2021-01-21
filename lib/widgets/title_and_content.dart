import 'package:flutter/material.dart';

class TitleAndContent extends StatelessWidget {
  const TitleAndContent({this.title, this.content});
  final String title, content;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        style: TextStyle(color: Colors.black),
        children: <TextSpan>[
          TextSpan(
              text: '$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
          TextSpan(
            text: '$content',
          ),
        ],
      ),
    );
  }
}
