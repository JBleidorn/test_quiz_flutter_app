import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_quiz_flutter_app/screens/resultpageScreen.dart';


class GetJson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //greift auf das JSON zu und wandelt die Attribut-Wert-Paare in Strings um
    return FutureBuilder(
      future: DefaultAssetBundle.of(context).loadString("assets/python.json"),//eigenes Json erstellen mit Fragen und Antworten und in Assets speiechern -> pubspec.jaml!!
      builder: (context, snapshot){
        List mydata = json.decode(snapshot.data.toString());
        if(mydata == null){ //solange keine Date vorhanden, wird der Scaffold angezeigt
          return Scaffold(
            body: Center(
              child: Text(
                "Loading"
              ),
            ),
          );
        }else{
          return QuizPageScreen(mydata : mydata);
        }
      },
    );
  }
}


class QuizPageScreen extends StatefulWidget {

  var mydata;

  QuizPageScreen({Key key, @required this.mydata}) : super(key : key); // ruft sich selbst mit mydata auf

  @override
  _QuizPageScreenState createState() => _QuizPageScreenState(mydata);
}

class _QuizPageScreenState extends State<QuizPageScreen> {

  var mydata;
  _QuizPageScreenState(this.mydata);

  //Variablen mit Farben erstellen, auf die später zugegriffen werden kann
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  //variable zum Punktezählen
  int marks = 0;
  //Nummer der Frage und Stelle im JSON
  int i = 1;
  //timer
  int timer = 30;
  String showtimer = "30";

  Map<String, Color> btncolor = {
    "a" : Colors.indigoAccent,
    "b" : Colors.indigoAccent,
    "c" : Colors.indigoAccent,
    "d" : Colors.indigoAccent,
  };

  bool canceltimer = false;

  //timer startet sobald der screen erstellt ist
  @override
  void initState(){
    starttimer();
    super.initState();
  }

  //überschreibt die setState funktion, sofern sie montiert ist??
  @override
  void setState(fn){
    if(mounted){
      super.setState(fn);
    }
  }

  /*erstellt timer, der im sekundetakt zählt
  wenn 0, nächste Frage wird angezeigt
  ansonsten timer runterzählen und anzeigen lassen*/
  void starttimer()async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t){
      setState(() {
        if(timer < 1){
          t.cancel();
          nextquestion();
        }else if(canceltimer == true){
          t.cancel();
        }else{
          timer = timer - 1;

        }
        showtimer = timer.toString();
      });
    });
  }

  //über i auf eine neue Frage zugreifen, die Farben aller Btn wieder auf default setzen
  void nextquestion(){
    canceltimer = false;
    timer = 30;
    setState(() {
      if (i < 10){
        i++;
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ResultpageScreen(marks : marks),
        ));
      }
      btncolor["a"] = Colors.indigoAccent;
      btncolor["b"] = Colors.indigoAccent;
      btncolor["c"] = Colors.indigoAccent;
      btncolor["d"] = Colors.indigoAccent;
    });
    starttimer();

  }

  void checkanswer(String k){
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]){
      marks = marks + 5;
      colortoshow = right;
    }else{
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      canceltimer = true;
    });

    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 20.0,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
          child: Text(
            //"a",
            mydata[1][i.toString()][k],
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
            maxLines: 1,
          ),
        color: btncolor[k],
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[700],
        minWidth: 200.0,
        height: 45.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown, DeviceOrientation.portraitUp
    ]);
    return WillPopScope(
      onWillPop: (){
        return showDialog(
            context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "QuizStar",
            ),
            content: Text(
              "Du kannst an diesem Punkt nicht zurück gehen.",
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
                child: Text(
                  "OK",
                ),
              ),
            ],
          )
        );
      },
        child:Scaffold(
          body: Column(
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      //"Dies ist eine Beispielfrage, die je nach Inhalt gefüllt werden kann?",
                      //mydata[0]["1"], // sucht die Frage 1 aus dem ersten Block heraus
                     mydata[0][i.toString()],
                      style: TextStyle(
                        fontSize: 16.0,

                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        choicebutton("a"),
                        choicebutton("b"),
                        choicebutton("c"),
                        choicebutton("d"),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: Text(
                        showtimer,
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ]
          ),
        ),
    );
  }
}
