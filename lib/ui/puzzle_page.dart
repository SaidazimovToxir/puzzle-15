import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_event.dart';
import 'package:puzzle_15/blocs/puzzle_state.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('15 Puzzle'),
        centerTitle: true,
      ),
      body: BlocConsumer<PuzzleBloc, PuzzleState>(
        listener: (context, state) {
          if (state.isCompleted) {
            _showWinDialog(context, state.timeElapsed);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Time: ${state.timeElapsed}s',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, index) {
                      return _buildTile(context, state.tiles[index]);
                    },
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.teal,
                      onPressed: () {
                        context.read<PuzzleBloc>().add(PuzzleShuffled());
                      },
                      child: const Text(
                        'Restart',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildTile(BuildContext context, int tile) {
    return GestureDetector(
      onTap: tile == 0
          ? null
          : () {
              context.read<PuzzleBloc>().add(TileMoved(tile));
            },
      child: Container(
        decoration: BoxDecoration(
          color: tile == 0 ? Colors.grey[300] : Colors.teal,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (tile != 0)
              const BoxShadow(
                color: Colors.black26,
                blurRadius: 4,
                offset: Offset(2, 2),
              ),
          ],
        ),
        child: Center(
          child: Text(
            tile == 0 ? '' : '$tile',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: tile == 0 ? Colors.transparent : Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _showWinDialog(BuildContext context, int timeElapsed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('You completed the puzzle in $timeElapsed seconds!'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
