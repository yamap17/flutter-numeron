import 'package:flutter/material.dart';
import 'package:numeron/widgets/number_card.dart';

class SelectedNumbersBoard extends StatelessWidget {
  const SelectedNumbersBoard({
    super.key,
    this.height = 150,
    this.color = const Color.fromARGB(255, 152, 127, 202),
    required this.selectedNumbers,
    this.count = 3,
  });

  final List<int> selectedNumbers;
  final int count;
  final double height;
  final Color color;

  void _removeNumber(int index) {
    if (selectedNumbers.isEmpty && selectedNumbers.length <= index + 1) {
      return;
    }
    if (!selectedNumbers.asMap().containsKey(index)) {
      return;
    }
    // setState(() {
    //   selectedNumbers.removeAt(i);
    // });
  }

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
                selectedNumbers: selectedNumbers,
                index: i,
                number: selectedNumbers.contains(i) ? selectedNumbers[i] : null,
                onTap: () => _removeNumber(i),
              )
          ],
        ));
  }
}
