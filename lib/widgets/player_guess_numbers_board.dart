import 'package:flutter/material.dart';
import 'package:numeron/widgets/number_card.dart';

class PlayerGuessNumbersBoard extends StatelessWidget {
  const PlayerGuessNumbersBoard({
    super.key,
    this.height = 150,
    this.count = 3,
    this.color = const Color.fromARGB(255, 152, 127, 202),
    required this.playerGuessNumbers,
    required this.onTap,
  });

  final Map<int, int?> playerGuessNumbers;
  final int count;
  final double height;
  final Color color;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: height,
        color: color,
        padding: const EdgeInsets.only(top: 20, bottom: 20),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < count; i++)
              NumberCard(
                number: playerGuessNumbers[i],
                onTap: () => onTap,
              )
          ],
        ));
  }
}
