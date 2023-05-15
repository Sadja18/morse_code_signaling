class MorseCode {
  static bool cancel = false;
  static int unit = 300;

  static Map<String, String> morseDict = {
    "a": ".-",
    "b": "-...",
    "c": "-.-.",
    "d": "-..",
    "e": ".",
    "f": "..-.",
    "g": "--.",
    "h": "....",
    "i": "..",
    "j": ".---",
    "k": "-.-",
    "l": ".-..",
    "m": "--",
    "n": "-.",
    "o": "---",
    "p": ".--.",
    "q": "--.-",
    "r": ".-.",
    "s": "...",
    "t": "-",
    "u": "..-",
    "v": "...-",
    "w": ".--",
    "x": "-..-",
    "y": "-.--",
    "z": "--..",
    "0": ".----",
    "1": "..---",
    "2": "...--",
    "3": "....-",
    "4": ".....",
    "5": "-....",
    "6": "--...",
    "7": "---..",
    "8": "----.",
    "9": "-----",
  };

  //converts the string to morse code using our dict

  //each letter is followed by a space

  //each is followed by # so we can differentiate

  //between spaces between words and between letters
  static String stringToMorse(String entry) {
    String morse = "";

    for (int i = 0; i < entry.length; i++) {
      String letter = entry[i].toLowerCase();

      if (letter == " ") {
        morse += "/ ";
      } else if (morseDict.containsKey(letter)) {
        morse += morseDict[letter]!;
        morse += " ";
      }
    }
    return morse;
  }
}
