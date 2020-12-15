import 'package:flutter/material.dart';

class CircularMaterialSpinner extends StatelessWidget {
  bool loading;
  double height;
  double width;
  Widget child;
  double strokeWidth;
  final color;

  CircularMaterialSpinner({
    this.color,
    this.loading,
    this.height = 40.0,
    this.width = 40.0,
    this.child,
    this.strokeWidth = 4.0
  });

  @override
  Widget build(BuildContext context) {
    if(loading){
      return Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
              strokeWidth: strokeWidth,
              valueColor: (color != null )
                  ? AlwaysStoppedAnimation<Color>(color)
                  : AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor)
          ),
        ),
      );
    }else{
      return Container(
        child: child,
      );
    }
  }
}
