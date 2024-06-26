import 'package:flutter/material.dart';
import 'package:numeron/ui/game/provider.dart';
import 'package:numeron/ui/game/result_screen.dart';
import 'package:numeron/utils/analytics.dart';
import 'package:numeron/utils/initialize_wrapper.dart';
import 'package:numeron/widgets/guess_result_card_list_board.dart';
import 'package:numeron/widgets/number_card.dart';
import 'package:numeron/widgets/player_guess_numbers_board.dart';
import 'package:numeron/widgets/text_elevated_button.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatelessWidget {
  GameScreen({super.key, required this.title});

  final String title;
  final int count = 3;
  final List<int> numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    final GameProvider gameProvider = Provider.of<GameProvider>(context, listen: true);

    initialize() {
      Analytics().logPage(title);
      gameProvider.initialize();
    }

    return InitializeWrapper(
        onInit: initialize,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(title),
          ),
          body: Column(
            children: <Widget>[
              PlayerGuessNumbersBoard(
                playerGuessNumbers: gameProvider.playerGuessNumbers,
                onTap: (int index) => gameProvider.unselectNumber(index),
              ),
              TextElevatedButton(
                onPressed: gameProvider.restartGame,
                text: 'Restart',
              ),
              GuessResultCardListBoard(
                guessResults: gameProvider.guessResults,
              ),
              Container(
                padding: const EdgeInsets.only(top: 80, bottom: 50),
                alignment: Alignment.center,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        // 0~9 の数字を表示するカードを配置する
                        for (var number in numbers)
                          NumberCard(
                            number: number,
                            onTap: () {
                              debugPrint('Card tapped: $number');
                              // 選択した数字が3つ以上になったら、選択できないようにする
                              if (gameProvider.playerGuessNumbers.length >= count) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                    content: Text('Only $count numbers can be selected'),
                                  ),
                                );
                                return;
                              }
                              // 選択した数字がすでに選択されている場合、選択できないようにする
                              if (gameProvider.playerGuessNumbers.contains(number)) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration: const Duration(milliseconds: 500),
                                    content: Text('The number $number is already selected'),
                                  ),
                                );
                                return;
                              }
                              gameProvider.selectNumber(number);
                            },
                          ),
                      ],
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  if (gameProvider.playerGuessNumbers.length != count) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: const Duration(milliseconds: 500),
                        content: Text('Please select $count numbers'),
                      ),
                    );
                    return;
                  }

                  bool result = gameProvider.guess(gameProvider.playerGuessNumbers, gameProvider.targetNumbers);
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
                      return const ResultScreen(
                        title: 'Winner!',
                      );
                    }),
                  );
                },
                child: const Icon(Icons.check),
              ),
            ],
          ),
        ));
  }
}
