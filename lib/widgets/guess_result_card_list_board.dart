import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';

class GuessResultCardListBoard extends StatelessWidget {
  const GuessResultCardListBoard({
    super.key,
    this.height = 280,
    required this.guessResults,
  });

  // guessResults は GuessResult のリスト
  final List<GuessResult> guessResults;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child: ListView(
          scrollDirection: Axis.vertical,
          children: <Widget>[
            for (var guess in guessResults)
              Container(
                padding: const EdgeInsets.only(right: 10, left: 10),
                alignment: Alignment.center,
                child: Card(
                  margin: const EdgeInsets.all(5),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      child: Text(
                        '${guess.playerGuessNumbers.join()}   Hits: ${guess.hits}, Blows: ${guess.blows}',
                        style: const TextStyle(fontSize: 20),
                      )),
                ),
              )
          ],
        ));
  }
}
