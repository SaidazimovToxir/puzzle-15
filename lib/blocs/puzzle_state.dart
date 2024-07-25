class PuzzleState {
  final List<int> tiles;
  final bool isCompleted;
  final int timeElapsed;

  const PuzzleState({
    required this.tiles,
    this.isCompleted = false,
    this.timeElapsed = 0,
  });

  factory PuzzleState.initial() {
    List<int> initialTiles = List.generate(15, (index) => index + 1);
    initialTiles.add(0);
    return PuzzleState(tiles: initialTiles);
  }

  PuzzleState copyWith({
    List<int>? tiles,
    bool? isCompleted,
    int? timeElapsed,
  }) {
    return PuzzleState(
      tiles: tiles ?? this.tiles,
      isCompleted: isCompleted ?? this.isCompleted,
      timeElapsed: timeElapsed ?? this.timeElapsed,
    );
  }
}
