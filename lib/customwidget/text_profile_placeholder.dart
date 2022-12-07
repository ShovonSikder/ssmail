import 'package:flutter/material.dart';

class TextProfilePlaceholder extends StatelessWidget {
  final String text;
  final double height;
  final double width;
  final Color bgColor;
  const TextProfilePlaceholder({
    Key? key,
    required this.text,
    this.height = 65,
    this.width = 65,
    this.bgColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Colors.black12),
          borderRadius: BorderRadius.circular(
            //dynamic radius
            ((height + width) / 2) / 2,
          ),
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ((height + width) / 2) * (30 / 100), //dynamic font size
            fontWeight: FontWeight.bold,
            color: Colors.black54,
          ),
        ),
      ),
    );
  }
}
