import 'package:flutter/material.dart';

import 'encoders/morse.dart';
import 'flash/controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController = TextEditingController();
  String currentLetter = "";
  String currentMorse = "";
  String morseString = "";
  String inputString = "";
  bool errorFlag = false;
  String errorMessage = "";

  // Button text
  String buttonText = "Flash it!";

  // Check if buttons are active
  bool isActive = false;

  void startFlash() async {
    setInputText(myController.text);
    setMorseCode(MorseCode.stringToMorse(myController.text));
    List<String> morseWords = morseString.split("/ ");
    int stringLetterIndex = 0;
    for (int i = 0; i < morseWords.length; i++) {
      String morseWord = morseWords[i];
      List<String> morseLetters = morseWord.split(" ");
      morseLetters.removeLast();

      for (int j = 0; j < morseLetters.length; j++) {
        String morseLetter = morseLetters[j];
        updateLetters(myController.text[stringLetterIndex], morseLetter);
        await FlashController.flashCharacter(morseLetter);
        stringLetterIndex++;
      }
      FlashController.holdForPause(7 * FlashController.timeOut);
    }
    updateLetters("", "");
  }

  //syncs the letter currently being flashed with one on screen
  void updateLetters(String letter, String morse) {
    setState(() {
      currentLetter = letter;
      currentMorse = morse;
    });
  }

  void setMorseCode(String morse) {
    setState(() {
      morseString = morse;
    });
  }

  void setInputText(String input) {
    setState(() {
      inputString = input;
    });
  }

  void setErrorFlag(String e) {
    setState(() {
      errorFlag = true;
      errorMessage = e;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 70,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: myController,
                      textAlign: TextAlign.center,
                      decoration: const InputDecoration(
                        hintText: 'What do you wanna flash out?',
                      ),
                      maxLength: 50,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: const Text('Flash'),
                      onPressed: () {
                        startFlash();
                      },
                    ),
                  ),
                  Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        inputString != '' ? '$inputString -> $morseString' : '',
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentLetter,
                        style: const TextStyle(fontSize: 40),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        currentMorse,
                        style: const TextStyle(fontSize: 30),
                      ),
                    )
                  ]),
                  const FlashController()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
