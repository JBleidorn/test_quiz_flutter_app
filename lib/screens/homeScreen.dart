import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_quiz_flutter_app/screens/quizpageScreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<String> name = [
    "Mutimediagrundlagen",
    "Technische Grundlagen der Informatik",
    "Mediendidaktik und E-Learning",
    "Betriebssysteme",
    "Programmierung 1",
    "Programmierung 2",
    "Management und Marketing",
  ];

  Widget customcard(String titel){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical:20.0,
        horizontal: 30.0,
      ),
      child: InkWell(
        onTap: (){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => GetJson(),
          ));
        },
        child: Material(
          color: Colors.indigo,
          elevation: 10.0,
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 10.0,
                  ),
                  child: Text(
                      titel,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return Scaffold(
      backgroundColor: Colors.indigoAccent,
      appBar: AppBar(
        title: Text(
          "QuizStar",
        )
      ),
      body: ListView(
        children: <Widget>[
          customcard(name[0]),
          customcard(name[1]),
          customcard(name[2]),
          customcard(name[3]),
          customcard(name[4]),
          customcard(name[5]),
          customcard(name[6]),
        ]
      ),
    );
  }
}
