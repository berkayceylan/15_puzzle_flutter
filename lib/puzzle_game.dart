import 'dart:math';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fifteen_puzzle/components/bottom.dart';
import 'package:fifteen_puzzle/components/tile.dart';
import 'package:fifteen_puzzle/constants.dart';
class PuzzleGame extends StatefulWidget {
  @override
  _PuzzleGameState createState() => _PuzzleGameState();
}

class _PuzzleGameState extends State<PuzzleGame> {
  List<int> puzzleList = [];
  List<bool> isCorrectList = [];
  int? emptyIndex;
  int moves = 0;
  Timer? timer;
  int secondsElapsed = 0;

  @override
  void initState() {
    super.initState();

    shufflePuzzle();
  }
  void shufflePuzzle() {
    // generate random list of integers from 1 to 15
    List<int> numbers = List.generate(15, (i) => i + 1);
    numbers.shuffle(Random());

    // check the parity of the permutation
    int inversions = 0;
    for (int i = 0; i < numbers.length; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] > numbers[j]) {
          inversions++;
        }
      }
    }
    bool isSolvable = (inversions % 2 == 0);

    // if the permutation is not solvable, swap the last two elements
    if (!isSolvable) {
      int temp = numbers[numbers.length - 1];
      numbers[numbers.length - 1] = numbers[numbers.length - 2];
      numbers[numbers.length - 2] = temp;
    }

    setState(() {
      puzzleList.clear();
      puzzleList.addAll(numbers);
      puzzleList.add(0);
      emptyIndex = 15;
      isCorrectList = List.filled(16, false);
      changeColor();
      moves = 0;
      secondsElapsed = 0;
      timer?.cancel();
      timer = null;
    });
    // insert numbers into puzzleList and set emptyIndex
  }


  bool checkWin() {
    for (int i = 0; i < puzzleList.length - 1; i++) {
      if (puzzleList[i] != i + 1) {
        return false;
      }
    }
    return true;
  }

  void changeColor() {
    for (int i = 0; i < puzzleList.length - 1; i++) {
      if (puzzleList[i] == i + 1) {
        isCorrectList[i] = true;
      } else {
        isCorrectList[i] = false;
      }
    }
  }

  void moveTile(int index) {
    timer ??= Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          secondsElapsed++;
        });
      });
    if ((index % 4 == emptyIndex! % 4 && (index - emptyIndex!).abs() == 4) ||
        (index ~/ 4 == emptyIndex! ~/ 4 && (index - emptyIndex!).abs() == 1)) {
      setState(() {
        // swap tiles
        int temp = puzzleList[index];
        puzzleList[index] = puzzleList[emptyIndex!];
        puzzleList[emptyIndex!] = temp;

        // update emptyIndex
        emptyIndex = index;
        changeColor();
        moves++;
        if (checkWin()) {
          timer?.cancel();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Congratulations!'),
                content: Text(
                    'You solved the puzzle in $moves moves and $secondsElapsed seconds.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    }
  }

  Color getTileColor(int index) {
    if (isCorrectList[index]) {
      return correctColor;
    } else if (puzzleList[index] == 0) {
      return emptyColor;
    } else {
      return blockColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 450, maxHeight: 600),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    ),
                    itemCount: 16,
                    itemBuilder: (BuildContext context, int index) {
                      return Tile(number: puzzleList[index], color: getTileColor(index), onTap: ()=>moveTile(index));
                    },
                  ),
                ),
                Bottom(
                  moves: moves.toString(),
                  secondsElapsed: secondsElapsed.toString(),
                  shuffle: shufflePuzzle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
