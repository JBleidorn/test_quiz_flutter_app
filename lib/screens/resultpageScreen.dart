import 'package:flutter/material.dart';

import 'homeScreen.dart';

class ResultpageScreen extends StatefulWidget {

  //anzahl der Punkte aus dem Quiz werden übergeben
  int marks;
  ResultpageScreen({Key key, @required this.marks}) : super(key : key);

  @override
  _ResultpageScreenState createState() => _ResultpageScreenState(marks);
}

class _ResultpageScreenState extends State<ResultpageScreen> {

  List<String> images = [
    "images/succes.png",
    "images/good_job.png",
    "images/bad_job.png",
  ];

  String message;
  String image;

  @override
  void initState(){
    if (marks < 20){
      image = images[2];
      message = "Du hast es versucht....\n" + "Du hast $marks Punkte erreicht";
    }else if ( marks < 35){
      image = images[1];
      message = "Das kannst du noch besser....\n" + "Du hast $marks Punkte erreicht";
    }else{
      image = images[0];
      message = "Das hast du super gemacht....\n" + "Du hast $marks Punkte erreicht";
    }
    super.initState();
  }

  int marks;
  _ResultpageScreenState(this.marks);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Deine Ergebnisse"
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
           flex: 7,
           child: Material(
             elevation: 10.0,
             child: Container(
               child: Column(
                 children: <Widget>[
                   Material(
                     child: Container(
                       width: 300.0,
                       height: 300.0,
                       child:ClipRect(
                         child: Image(
                           image: AssetImage(
                             image,
                           ),
                         ),
                       ),
                     ),
                   ),
                   Padding(
                     padding: const EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                     ),
                     child: Center(
                       child: Text(
                         message,
                         style: TextStyle(
                           fontSize: 20.0,
                         ),
                       ),
                     ),
                   ),
                 ]
                ),
              ),
            ),
           ),
            Expanded(
             flex: 4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      onPressed: (){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                      },
                      child: Text(
                        "continue",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 25.0,
                      ),
                      borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                      splashColor: Colors.indigoAccent,
                    ),
                  ],
              ),
            ),
          ]),
        );
  }
}
