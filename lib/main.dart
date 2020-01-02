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
    flutterTts.setLanguage("en-US");

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

//    var languages = await speech.locales();
//    print("Locales available: $languages");
    print("Available: $available");
    if (available) {
      speech.listen(
        onResult: (result) {
          print("Recognized Words: ${result.recognizedWords}");
          flutterTts.speak(result.recognizedWords);
        },
        listenFor: Duration(seconds: 5),
      );
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }
}
