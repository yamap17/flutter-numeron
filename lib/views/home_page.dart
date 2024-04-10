import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numeron/models/guess.dart';
import 'package:numeron/views/result_page.dart';
import 'package:numeron/widgets/guess_card.dart';
import 'package:numeron/widgets/number_card.dart';
import 'package:numeron/widgets/text_elevated_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> targetNumbers = [];
  List<int> selectedNumbers = [];
  List<Guess> guesses = [];
  final int count = 3;

  @override
  void initState() {
    super.initState();

    setState(() {
      targetNumbers = generateRandomNumbers(count);
      guesses = [];
    });
  }

  List<int> generateRandomNumbers(int count) {
    List<int> numbers = [];
    while (numbers.length < count) {
      int randomNumber = Random().nextInt(10);
      if (!numbers.contains(randomNumber)) {
        numbers.add(randomNumber);
      }
    }
    return numbers;
  }

  void _unselectNumber(int index) {
    if (selectedNumbers.isEmpty && selectedNumbers.length <= index + 1) {
      return;
    }
    if (!selectedNumbers.asMap().containsKey(index)) {
      return;
    }
    setState(() {
      selectedNumbers.removeAt(index);
    });
  }

  void _selectNumber(int number) => {
        setState(() {
          selectedNumbers.add(number);
        })
      };

  bool checkResult(List<int> selectedNumbers) {
    int hits = 0;
    int blows = 0;

    for (int i = 0; i < count; i++) {
      if (targetNumbers[i] == selectedNumbers[i]) {
        hits++;
      } else if (targetNumbers.contains(selectedNumbers[i])) {
        blows++;
      }
    }

    final resultSelectedNumbers = List<int>.unmodifiable(selectedNumbers);

    Guess guess = Guess(
      selectedNumbers: resultSelectedNumbers,
      hits: hits,
      blows: blows,
    );
    setState(() {
      guesses = [...guesses, guess];
      selectedNumbers.clear();
    });

    if (hits == count) {
      return true;
    } else {
      return false;
    }
  }

  void _restartGame() => {
        setState(() {
          targetNumbers = generateRandomNumbers(count);
          guesses.clear();
          selectedNumbers.clear();
        })
      };

  List<int> numberCards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Container(
              height: 150,
              color: const Color.fromARGB(255, 152, 127, 202),
              padding: const EdgeInsets.only(top: 20, bottom: 20),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < count; i++)
                    NumberCard(
                      number: selectedNumbers.length > i ? selectedNumbers[i] : null,
                      onTap: () => _unselectNumber(i),
                    )
                ],
              )),
          TextElevatedButton(
            onPressed: _restartGame,
            text: 'Restart',
          ),
          Container(
            height: 280,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[for (var guess in guesses) GuessCard(guess: guess)],
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 80, bottom: 50),
            alignment: Alignment.center,
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: <Widget>[
                    // 0~9 の数字を表示するカードを配置する
                    for (var number in numberCards)
                      NumberCard(
                        number: number,
                        onTap: () {
                          debugPrint('Card taped');
                          // 選択した数字が3つ以上になったら、選択できないようにする
                          if (selectedNumbers.length >= count) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text('$countつまでしか追加できません'),
                              ),
                            );
                            return;
                          }
                          // 選択した数字がすでに選択されている場合、選択できないようにする
                          if (selectedNumbers.contains(number)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text('$number はすでに追加されています'),
                              ),
                            );
                            return;
                          }
                          _selectNumber(number);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              duration: const Duration(milliseconds: 500),
                              content: Text('$numberを追加しました'),
                            ),
                          );
                        },
                      ),
                  ],
                )),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (selectedNumbers.length < count) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text('3桁の数字を入力してください'),
              ),
            );
            return;
          }

          bool result = checkResult(selectedNumbers);
          if (!result) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text('Try again!'),
              ),
            );
            return;
          }
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              return const ResultPage(
                title: 'Winner!',
              );
            }),
          );
        },
        child: const Icon(Icons.check),
      ),
    );
  }
}
