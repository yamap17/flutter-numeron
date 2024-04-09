// ignore_for_file: file_names
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:numeron/views/ResultPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class Result {
  final List<int> inputNumbers;
  final int hits;
  final int blows;

  Result({
    required this.inputNumbers,
    required this.hits,
    required this.blows,
  });
}

class _HomePageState extends State<HomePage> {
  List<int> targetNumbers = [];
  List<int> inputNumbers = [];
  List<Result> results = [];
  final int count = 3;

  @override
  void initState() {
    super.initState();

    setState(() {
      targetNumbers = generateRandomNumbers(count);
      results = [];
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

  checkResult(List<int> inputNumbers) {
    int hits = 0;
    int blows = 0;

    for (int i = 0; i < count; i++) {
      if (targetNumbers[i] == inputNumbers[i]) {
        hits++;
      } else if (targetNumbers.contains(inputNumbers[i])) {
        blows++;
      }
    }

    final resultInputNumbers = List<int>.unmodifiable(inputNumbers);

    Result result = Result(
      inputNumbers: resultInputNumbers,
      hits: hits,
      blows: blows,
    );
    setState(() {
      results = [...results, result];
      inputNumbers.clear();
    });

    if (hits == count) {
      return true;
    } else {
      return false;
    }
  }

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
                    Card(
                        margin: const EdgeInsets.all(5),
                        elevation: 5,
                        child: InkWell(
                          splashColor: const Color.fromARGB(255, 222, 206, 251),
                          onTap: () {
                            if (inputNumbers.isEmpty && inputNumbers.length <= i + 1) {
                              return;
                            }
                            if (!inputNumbers.asMap().containsKey(i)) {
                              return;
                            }
                            final number = inputNumbers[i];
                            setState(() {
                              inputNumbers = inputNumbers..removeAt(i);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text('$numberを削除しました'),
                              ),
                            );
                          },
                          child: SizedBox(
                            height: 80,
                            width: 50,
                            child: Text(
                              '${inputNumbers.length > i ? inputNumbers[i] : ''}',
                              style: const TextStyle(fontSize: 45),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )),
                ],
              )),
          Container(
            alignment: Alignment.center,
            child: ElevatedButton(
                child: const Text('Restart'),
                onPressed: () {
                  setState(() {
                    targetNumbers = generateRandomNumbers(count);
                    results.clear();
                    inputNumbers.clear();
                  });
                }),
          ),
          Container(
            height: 270,
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                for (var result in results)
                  Card(
                    margin: const EdgeInsets.all(5),
                    child: Text(
                      '${result.inputNumbers} => Hits: ${result.hits}, Blows: ${result.blows}',
                      style: const TextStyle(fontSize: 20),
                    ),
                  ),
              ],
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
                      Card(
                          margin: const EdgeInsets.all(5),
                          elevation: 5,
                          child: InkWell(
                            splashColor: const Color.fromARGB(255, 222, 206, 251),
                            onTap: () {
                              debugPrint('Card taped');
                              setState(() {
                                if (inputNumbers.length >= count) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(milliseconds: 500),
                                      content: Text('$countつまでしか追加できません'),
                                    ),
                                  );
                                  return;
                                }
                                if (inputNumbers.contains(number)) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration: const Duration(milliseconds: 500),
                                      content: Text('$number はすでに追加されています'),
                                    ),
                                  );
                                  return;
                                }
                                inputNumbers.add(number);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                    content: Text('$numberを追加しました'),
                                  ),
                                );
                              });
                            },
                            child: SizedBox(
                              height: 80,
                              width: 50,
                              child: Text(
                                '$number',
                                style: const TextStyle(fontSize: 45),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                  ],
                )),
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (inputNumbers.length < count) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text('3桁の数字を入力してください'),
              ),
            );
            return;
          }

          bool result = checkResult(inputNumbers);

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
