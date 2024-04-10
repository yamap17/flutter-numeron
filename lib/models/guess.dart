class Guess {
  Guess({
    required this.selectedNumbers,
    required this.hits,
    required this.blows,
  });

  final List<int> selectedNumbers;
  final int hits;
  final int blows;
}
