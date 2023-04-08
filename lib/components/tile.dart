import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int number;
  final Color color;
  final Function() onTap;
  const Tile({Key? key, required this.number, required this.color, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          // color: getTileColor(index),
          color: color ,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 5,
              spreadRadius: 1,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        // color: puzzleList[index] == 0 ? Colors.white : Colors.blue,
        child: Center(
          child: Text(
            number == 0 ? '' : number.toString(),
            style: const TextStyle(
              fontSize: 50,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
