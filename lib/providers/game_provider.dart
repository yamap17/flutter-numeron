import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';

class GameProvider with ChangeNotifier {
  final int count = 3;
  List<int> targetNumbers = [];
  Map<int, int?> playerGuessNumbers = {
    0: null,
    1: null,
    2: null,
  };
  List<GuessResult> guessResults = [];

  void setRandomTargetNumbers(int count) {
    debugPrint('setRandomTargetNumbers');

    List<int> numbers = [];
    while (numbers.length < count) {
      int randomNumber = Random().nextInt(10);
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }
    targetNumbers = numbers;
    notifyListeners();
  }

  void unselectNumber(int index) {
    debugPrint('unselectNumber');

    if (playerGuessNumbers.isEmpty && playerGuessNumbers.length <= index + 1) {
      return;
    }
    if (!playerGuessNumbers.containsKey(index)) {
      return;
    }
    playerGuessNumbers[index] = null;
    notifyListeners();
  }

  void selectNumber(int number) {
    debugPrint('selectNumber');

    playerGuessNumbers[playerGuessNumbers.keys.firstWhere((key) => playerGuessNumbers[key] == null)] = number;
    notifyListeners();
  }

  void resetGuessResults() {
    debugPrint('resetGuessResults');

    guessResults.clear();
    notifyListeners();
  }

  void setGuessResults(List<GuessResult> guessResults) {
    debugPrint('setGuessResults');

    this.guessResults = guessResults;
    notifyListeners();
  }

  void resetPlayerGuessNumbers() {
    debugPrint('resetPlayerGuessNumbers');

    playerGuessNumbers = {0: null, 1: null, 2: null};
    notifyListeners();
  }
}
