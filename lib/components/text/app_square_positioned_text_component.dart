import 'package:flutter/material.dart';

class AppSquarePositionedTextComponent extends StatelessWidget {
  final String text;
  final double squareSize;
  final double? left;
  final double? bottom;
  final double? top;
  final double? right;
  final Color color;
  final FontWeight? fontWeight;
  final double backgroundOpacity;
  final double backgroundDensity;
  final double textDensity;
  final IconData? icon;

  const AppSquarePositionedTextComponent(
      {super.key,
      required this.text,
      required this.squareSize,
      this.left,
      this.bottom,
      this.top,
      this.right,
      this.color = Colors.black,
      this.textDensity = 2,
      this.backgroundDensity = 2,
      this.backgroundOpacity = 0,
      this.icon,
      this.fontWeight = FontWeight.w400});

  @override
  Widget build(BuildContext context) {
    double containerSize = squareSize * (backgroundDensity / 100) * 3;
    return Positioned(
        left: left != null ? left! - (containerSize / 2) : null,
        bottom: bottom != null ? bottom! - (containerSize / 2) : null,
        top: top != null ? top! - (containerSize / 2) : null,
        right: right != null ? right! - (containerSize / 2) : null,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color.withOpacity(backgroundOpacity)),
          child: Center(child: icon != null ? _textWithIcon() : _text()),
        ));
  }

  Widget _text() {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(color: color, fontWeight: fontWeight, fontSize: squareSize * (textDensity / 100)),
    );
  }

  Widget _textWithIcon() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: squareSize * 0.008),
          child: Icon(
            icon,
            color: color.withOpacity(0.7),
            size: squareSize * (textDensity / 100),
          ),
        ),
        _text()
      ],
    );
  }
}
