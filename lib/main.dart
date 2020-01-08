import 'package:flutter/material.dart';
import 'package:test_quiz_flutter_app/screens/splashScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuizStar',
      theme: ThemeData(
       primarySwatch: Colors.indigo,
      ),
      home: SplashScreen(),
    );
  }
}

