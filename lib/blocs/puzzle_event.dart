abstract class PuzzleEvent {
  const PuzzleEvent();
}

class PuzzleInitialized extends PuzzleEvent {}

class TileMoved extends PuzzleEvent {
  final int tile;

  const TileMoved(this.tile);
}

class PuzzleShuffled extends PuzzleEvent {}

class TimerTicked extends PuzzleEvent {}
