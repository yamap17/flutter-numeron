import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';

class GameProvider with ChangeNotifier {
  final int count = 3;
  List<int> targetNumbers = [];
  List<int> playerGuessNumbers = [];
  List<GuessResult?> guessResults = [];

  void restartGame() {
    debugPrint('restartGame');

    targetNumbers = _setRandomTargetNumbers(count);
    guessResults.clear();
    playerGuessNumbers.clear();
    notifyListeners();
  }

  bool guess(List<int> playerGuessNumbers, List<int> targetNumbers) {
    debugPrint('guess');

    int hits = 0;
    int blows = 0;

    // 全ての数字が選択されているかチェック
    if (playerGuessNumbers.length != count) {
      throw Exception('Please select all numbers.');
    }
    // 同じ数字が選択されていないかチェック
    if (playerGuessNumbers.toSet().length != count) {
      throw Exception('Please select different numbers.');
    }

    for (int i = 0; i < count; i++) {
      if (targetNumbers[i] == playerGuessNumbers[i]) {
        hits++;
      } else if (targetNumbers.contains(playerGuessNumbers[i])) {
        blows++;
      }
    }
    final resultSelectedNumbers = List<int>.unmodifiable(playerGuessNumbers);

    GuessResult guessResult = GuessResult(
      playerGuessNumbers: resultSelectedNumbers,
      hits: hits,
      blows: blows,
    );
    guessResults = [...guessResults, guessResult];
    playerGuessNumbers.clear();
    notifyListeners();

    if (hits == count) {
      return true;
    } else {
      return false;
    }
  }

  void unselectNumber(int index) {
    debugPrint('unselectNumber');

    if (playerGuessNumbers.isEmpty && playerGuessNumbers.length <= index + 1) {
      return;
    }
    if (!playerGuessNumbers.asMap().containsKey(index)) {
      return;
    }
    playerGuessNumbers.removeAt(index);
    notifyListeners();
  }

  void selectNumber(int number) {
    debugPrint('selectNumber');

    playerGuessNumbers.add(number);
    notifyListeners();
  }

  List<int> _setRandomTargetNumbers(int count) {
    debugPrint('setRandomTargetNumbers');

    List<int> numbers = [];
    while (numbers.length < count) {
      int randomNumber = Random().nextInt(10);
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }
    return numbers;
  }
}
