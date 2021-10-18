import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wiseair_ui/src/country/country.dart';
import 'package:wiseair_ui/src/widgets/phone_input.dart';

import 'widgets/continue_with_button.dart';
import 'widgets/interactive_gradient_button.dart';
import 'widgets/separator_line.dart';

class LogInDialog extends StatefulHookWidget {
  const LogInDialog({Key? key}) : super(key: key);

  static void show(BuildContext context) {
    showDialog(context: context, builder: (_) => const LogInDialog());
  }

  @override
  State<LogInDialog> createState() => _LogInDialogState();
}

class _LogInDialogState extends State<LogInDialog> {
  static const double iconSize = 25;
  List<Country>? _countries;

  @override
  void initState() {
    getCountries();
    super.initState();
  }

  void getCountries() async {
    final jsonData = await rootBundle.loadString('json/countries.json');
    final list = json.decode(jsonData) as List<dynamic>;
    // ! There might be a better way to do this
    setState(() {
      _countries = list.map((e) => Country.fromJson(e)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textControllerPhoneNumber = useTextEditingController();
    final iCountry = useState<int>(0);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.all(0),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: SizedBox(
            width: constraints.maxWidth > 1000 ? 600 : constraints.maxWidth,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close_rounded),
                          splashRadius: 20,
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              "Log in or Sign up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SeparatorLine(),
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 25),
                      child: Text(
                        "Welcome to Airbnb",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 22),
                      ),
                    ),
                  ),
                  PhoneInput(
                      countries: _countries,
                      iCountry: iCountry,
                      textControllerPhoneNumber: textControllerPhoneNumber),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: RichText(
                      text: TextSpan(
                        text:
                            "We'll call or text you to confirm your number. Standard message and data rates apply. ",
                        style: const TextStyle(fontSize: 13),
                        children: [
                          TextSpan(
                            text: "Privacy Policy",
                            style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                print("Redirect");
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: InteractiveGradientButton(
                      text: "Continue",
                      height: 50,
                      onPressed: (){
                        if (textControllerPhoneNumber.text.isEmpty){
                          print("invalid phone number");
                        }else{
                          print("${_countries![iCountry.value].dialCode} ${textControllerPhoneNumber.text}");
                        }
                      },
                    ),
                  ),
                  const SeparatorLine(
                    text: "or",
                    padding: 10,
                  ),
                  ContinueWithButton(
                    onPressed: () {
                      print("Continue with Facebook");
                    },
                    name: "Facebook",
                    icon: const FaIcon(
                      FontAwesomeIcons.facebook,
                      size: iconSize,
                    ),
                  ),
                  // ! onPressed has not been implemented on the other buttons for simplicity
                  const ContinueWithButton(
                    name: "Google",
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      size: iconSize,
                    ),
                  ),
                  const ContinueWithButton(
                    name: "Apple",
                    icon: FaIcon(
                      FontAwesomeIcons.apple,
                      size: iconSize,
                    ),
                  ),
                  const ContinueWithButton(
                    name: "email",
                    icon: FaIcon(
                      FontAwesomeIcons.envelope,
                      size: iconSize,
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
