// ignore: unused_import
import 'package:quiz_app/quizpage.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

main() {
  runApp(Monapp());
}

class Monapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QUIZAPP',
      //home: HomePage(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/homepage',
      routes: {
        '/quizpage': (context) => QuizPage(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}