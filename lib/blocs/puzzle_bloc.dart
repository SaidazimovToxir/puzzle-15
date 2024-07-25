import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:puzzle_15/blocs/puzzle_event.dart';
import 'package:puzzle_15/blocs/puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  Timer? _timer;

  PuzzleBloc() : super(PuzzleState.initial()) {
    on<PuzzleInitialized>((event, emit) {
      emit(PuzzleState.initial());
    });

    on<PuzzleShuffled>((event, emit) {
      final tiles = List<int>.from(state.tiles);
      tiles.shuffle();
      emit(state.copyWith(tiles: tiles, isCompleted: false, timeElapsed: 0));
      _startTimer();
    });

    on<TileMoved>((event, emit) {
      final newState = _moveTile(event.tile, state);
      emit(newState);
      if (newState.isCompleted) {
        _stopTimer();
      }
    });

    on<TimerTicked>((event, emit) {
      emit(state.copyWith(timeElapsed: state.timeElapsed + 1));
    });
  }

  PuzzleState _moveTile(int tile, PuzzleState state) {
    final tiles = List<int>.from(state.tiles);
    final emptyIndex = tiles.indexOf(0);
    final tileIndex = tiles.indexOf(tile);

    // Check if the tile can be moved (adjacent to the empty space)
    if (_canTileMove(tileIndex, emptyIndex)) {
      tiles[emptyIndex] = tile;
      tiles[tileIndex] = 0;
    }

    return state.copyWith(
      tiles: tiles,
      isCompleted: _checkIfCompleted(tiles),
    );
  }

  bool _canTileMove(int tileIndex, int emptyIndex) {
    final rowTile = tileIndex ~/ 4;
    final colTile = tileIndex % 4;
    final rowEmpty = emptyIndex ~/ 4;
    final colEmpty = emptyIndex % 4;

    return (rowTile == rowEmpty && (colTile - colEmpty).abs() == 1) ||
        (colTile == colEmpty && (rowTile - rowEmpty).abs() == 1);
  }

  bool _checkIfCompleted(List<int> tiles) {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) {
        return false;
      }
    }
    return tiles[tiles.length - 1] == 0;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      add(TimerTicked());
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
