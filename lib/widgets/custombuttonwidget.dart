import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  final String text;
  final MaterialColor color;
  final double borderRadius;
  final double paddingVertical;
  final double paddingHorizontal;

  CustomButton({
    @required this.text,
    this.color = Colors.lightBlue,
    this.borderRadius = 6.0,
    this.paddingHorizontal = 0.0,
    this.paddingVertical = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: paddingHorizontal,
        vertical: paddingVertical,
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: 17),
      ),
    );
  }
}