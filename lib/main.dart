import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = new FlutterTts();
  SpeechToText speech = SpeechToText();

  @override
  Widget build(BuildContext context) {
    flutterTts.setLanguage("de-DE");

    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: listen,
          child: Text("Listen"),
        ),
      ),
    );
  }

  listen() async {
    bool available = await speech.initialize(
      onError: (error) => print("Error: ${error.toString()}"),
    );

    if (available) {
      speech.listen(
        onResult: (result) {
          if(result.finalResult == true) flutterTts.speak(result.recognizedWords);
        },
        listenFor: Duration(seconds: 5),
        localeId: "de_AT",
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }
}
