import 'package:flutter/material.dart';
import 'package:numeron/models/guess_result.dart';
import 'package:numeron/providers/game_provider.dart';
import 'package:numeron/views/result_page.dart';
import 'package:numeron/widgets/guess_result_card_list_board.dart';
import 'package:numeron/widgets/number_card.dart';
import 'package:numeron/widgets/player_guess_numbers_board.dart';
import 'package:numeron/widgets/text_elevated_button.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});

  final String title;
  final int count = 3;
  final List<int> numberCards = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    final GameProvider gameProvider = Provider.of<GameProvider>(context, listen: true);

    void restartGame() {
      debugPrint('restartGame');

      gameProvider.setRandomTargetNumbers(count);
      gameProvider.resetGuessResults();
      gameProvider.resetPlayerGuessNumbers();
    }

    bool guess(Map<int, int?> playerGuessNumbers, List<int> targetNumbers) {
      debugPrint('guess');

      int hits = 0;
      int blows = 0;

      if (playerGuessNumbers.containsValue(null)) {
        throw Exception('Please select all numbers.');
      }

      for (int i = 0; i < count; i++) {
        if (targetNumbers[i] == playerGuessNumbers[i]) {
          hits++;
        } else if (targetNumbers.contains(playerGuessNumbers[i])) {
          blows++;
        }
      }

      final resultSelectedNumbers = Map<int, int?>.unmodifiable(playerGuessNumbers);

      GuessResult guessResult = GuessResult(
        playerGuessNumbers: resultSelectedNumbers,
        hits: hits,
        blows: blows,
      );
      final guessResults = [...gameProvider.guessResults, guessResult];
      gameProvider.setGuessResults(guessResults);
      gameProvider.resetPlayerGuessNumbers();

      if (hits == count) {
        return true;
      } else {
        return false;
      }
    }

    return Scaffold(
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
            onPressed: restartGame,
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
                    for (var number in numberCards)
                      NumberCard(
                        number: number,
                        onTap: () {
                          debugPrint('Card taped');
                          // 選択した数字が3つ以上になったら、選択できないようにする
                          if (!gameProvider.playerGuessNumbers.containsValue(null)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text('$countつまでしか追加できません'),
                              ),
                            );
                            return;
                          }
                          // 選択した数字がすでに選択されている場合、選択できないようにする
                          if (gameProvider.playerGuessNumbers.containsValue(number)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: const Duration(milliseconds: 500),
                                content: Text('$number はすでに追加されています'),
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
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          if (gameProvider.playerGuessNumbers.containsValue(null)) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                duration: Duration(milliseconds: 500),
                content: Text('3桁の数字を入力してください'),
              ),
            );
            return;
          }

          bool result = guess(gameProvider.playerGuessNumbers, gameProvider.targetNumbers);
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
