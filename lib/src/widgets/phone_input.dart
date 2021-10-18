import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


import '../country/country.dart';

class PhoneInput extends HookWidget {
  final TextEditingController textControllerPhoneNumber;
  final List<Country>? countries;
  final ValueNotifier<int> iCountry;

  const PhoneInput(
      {Key? key,
      required this.countries,
        required this.iCountry,
      required this.textControllerPhoneNumber})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5),
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: DropdownButton<int>(
              value: iCountry.value,
              icon: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: FaIcon(FontAwesomeIcons.angleDown, size: 30,),
              ),
              iconSize: 15,
              isExpanded: true,
              itemHeight: 58,
              underline: const SizedBox(),
              onChanged: (int? newValue) {
                iCountry.value = newValue!;
              },
              items: countries == null
                  ? [
                      const DropdownMenuItem(
                        child: SizedBox(),
                        value: 0,
                      )
                    ]
                  : countries!.map<DropdownMenuItem<int>>((country) {
                      final i = countries!.indexOf(country);
                      return DropdownMenuItem(
                        value: i,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                              '${countries![i].name}(${countries![i].dialCode})'),
                        ),
                      );
                    }).toList(),
            ),
          ),
          Theme(
            data: ThemeData(
                primarySwatch: Colors.grey,
                inputDecorationTheme: const InputDecorationTheme(
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(5),
                          bottomRight: Radius.circular(5),
                          topRight: Radius.circular(0),
                          topLeft: Radius.circular(0),
                        )),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ))),
            child: SizedBox(
              height: 60,
              child: TextField(
                controller: textControllerPhoneNumber,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  // ! When labelText animates itself, it covers a part of
                  // ! the border, that's why I decided to set floatingLabelBehaviour
                  // ! to never
                  labelText: "Phone Number",
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
                  prefixText: countries == null
                      ? ""
                      : "${countries![iCountry.value].dialCode}  ",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}