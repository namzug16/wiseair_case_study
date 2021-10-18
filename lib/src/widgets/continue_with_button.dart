import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContinueWithButton extends HookWidget {
  final FaIcon icon;
  final String name;
  final Function? onPressed;

  const ContinueWithButton({
    required this.name,
    required this.icon,
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderColor = useState<Color>(Colors.grey);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: MouseRegion(
          onEnter: (_) {
            borderColor.value = Colors.black;
          },
          onExit: (_) {
            borderColor.value = Colors.grey;
          },
          child: OutlinedButton(
            onPressed: () {
              onPressed != null ? onPressed!() : null;
            },
            style: OutlinedButton.styleFrom(
              side: BorderSide(width: 2, color: borderColor.value),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: icon,
                ),
                Center(
                    child: Text(
                      "Continue with $name",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w900,
                        fontSize: 16,
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
