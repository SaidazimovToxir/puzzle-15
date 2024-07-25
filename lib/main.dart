import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_bloc.dart';
import 'package:puzzle_15/blocs/puzzle_event.dart';
import 'package:puzzle_15/ui/puzzle_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PuzzleBloc()..add(PuzzleInitialized()),
        child: const PuzzlePage(),
      ),
    );
  }
}
