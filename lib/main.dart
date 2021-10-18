import 'package:flutter/material.dart';

import 'src/log_in_dialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Airbnb',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        textTheme: const TextTheme(
          button: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 19),
        ),
      ),
      home: const Scaffold(
        backgroundColor: Colors.black87,
        body: LogInDialog(),
      ),
    );
  }
}
