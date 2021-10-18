import 'package:flutter/material.dart';

class SeparatorLine extends StatelessWidget {
  final String? text;
  final double? padding;

  const SeparatorLine({this.text, this.padding, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(color: Colors.grey, height: 1),
        Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: padding ?? 0),
              child: Text(
                text ?? "",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  backgroundColor: Colors.white,
                ),
              ),
            ))
      ],
    );
  }
}
