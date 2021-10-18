import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class InteractiveGradientButton extends HookWidget {
  final double width;
  final double height;
  final String text;
  final Function? onPressed;

  const InteractiveGradientButton(
      {this.width = double.infinity,
        this.height = double.infinity,
        this.onPressed,
        required this.text,
        Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final offset = useState<Offset>(Offset.zero);

    return SizedBox(
      height: height,
      width: width,
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: CustomPaint(
          painter: InteractiveGradientButtonPainter(offset.value),
          child: MouseRegion(
            onHover: (details) {
              offset.value = details.localPosition;
            },
            child: InkWell(
              onTap: () {
                onPressed == null ? null : onPressed!();
              },
              child: Center(
                child: Text(
                  "Continue",
                  style: Theme.of(context).textTheme.button
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class InteractiveGradientButtonPainter extends CustomPainter {
  final Offset offset;

  InteractiveGradientButtonPainter(this.offset);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPaint(Paint()
      ..shader = const RadialGradient(
          colors: [Colors.deepOrangeAccent, Colors.pink], radius: 2.5)
          .createShader(Rect.fromCircle(center: offset, radius: 100)));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}