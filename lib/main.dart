import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_recognition/speech_recognition.dart';

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
  int _counter = 0;
  FlutterTts flutterTts = new FlutterTts();

  void _incrementCounter() {
    setState(() {
      _counter++;
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
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future speak(int number) async{
    var result = await flutterTts.speak(number.toString());
  }

  listen() {
    bool _speechRecognitionAvailable;
    String _currentLocale;
    bool _isListening;
    String transcription;
    flutterTts.setLanguage("en-US");

    SpeechRecognition _speech = new SpeechRecognition();
    _speech.setAvailabilityHandler((bool result)
    => setState(() => _speechRecognitionAvailable = result));
    _speech.setRecognitionStartedHandler(()
    => setState(() => _isListening = true));
    _speech.setRecognitionResultHandler((String text)
    => setState(() =>  transcription = text));
    _speech.setRecognitionCompleteHandler(()
    => setState(() => _isListening = false));

    _speech
        .activate()
        .then((res) => setState(() => _speechRecognitionAvailable = res));

    _speech.listen(locale: "en-US").then((result) =>
        flutterTts.speak(result));

  }
}
