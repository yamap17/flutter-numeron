class GuessResult {
  GuessResult({
    required this.playerGuessNumbers,
    required this.hits,
    required this.blows,
  });

  final Map<int, int?> playerGuessNumbers;
  final int hits;
  final int blows;
}
