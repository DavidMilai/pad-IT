import 'package:flutter/material.dart';

import '../constants.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({this.height, this.width, this.child});

  final double height, width;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: kMyPadding, vertical: kMyPadding / 2),
      height: height,
      width: width,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(kMyPadding * 0.5),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 3),
              blurRadius: kMyPadding / 4,
              color: Colors.black.withOpacity(0.1),
            ),
          ]),
      child: child,
    );
  }
}
