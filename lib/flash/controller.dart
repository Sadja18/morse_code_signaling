import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

class FlashController extends StatelessWidget {
  const FlashController({super.key});

  static int timeOut = 300;

  static Future<void> checkIfTorchisAvailable() async {
    try {
      await TorchLight.isTorchAvailable();
    } catch (e) {
      if (kDebugMode) {
        log('error in checking if torch is available');
        log(e.toString());
      }
    }
  }

  static Future<void> holdForPause(int millisecondsValue) async {
    await Future.delayed(Duration(milliseconds: millisecondsValue));
  }

  static Future<void> flashTheTorch(int millisecondsValue) async {
    await TorchLight.enableTorch();
    await Future.delayed(Duration(milliseconds: millisecondsValue));
    await TorchLight.disableTorch();
  }

  static Future<bool> flashCharacter(String code) async {
    try {
      checkIfTorchisAvailable();
      for (int i = 0; i < code.length; i++) {
        String letter = code[i];
        if (letter == '.') {
          flashTheTorch(timeOut);
          await holdForPause(timeOut);
        } else if (letter == '-') {
          flashTheTorch(3 * timeOut);
          await holdForPause(3 * timeOut);
        }
        await holdForPause(timeOut);
      }
      await holdForPause(3 * timeOut);
      return true;
    } catch (e) {
      if (kDebugMode) {
        log("error in signaling a letter");
        log(e.toString());
      }
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
