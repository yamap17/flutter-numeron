class GuessResult {
  GuessResult({
    required this.playerGuessNumbers,
    required this.hits,
    required this.blows,
  });

  final List<int> playerGuessNumbers;
  final int hits;
  final int blows;
}
