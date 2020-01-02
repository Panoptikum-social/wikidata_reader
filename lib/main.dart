import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'Wikidata Reader'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterTts flutterTts = new FlutterTts();

  void _incrementCounter() {
    setState(() {
      listen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  listen() async {
    flutterTts.setLanguage("en-US");

    stt.SpeechToText speech = stt.SpeechToText();
    bool available = await speech.initialize(
      onStatus: (status) => print("Status: $status"),
      onError: (error) => print("Error: ${error.toString()}"),
    );
    print("After Initialized");
    print("Available: $available");
    if (available) {
      speech.listen(onResult: (result) {
        print("Recognized Words: ${result.recognizedWords}");
        flutterTts.speak(result.recognizedWords);
      });
    } else {
      print("The user has denied the use of speech recognition.");
    }
  }
}
