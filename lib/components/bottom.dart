import 'package:flutter/material.dart';
import 'package:fifteen_puzzle/constants.dart';

class Bottom extends StatelessWidget {
  final String moves, secondsElapsed;
  final void Function() shuffle;
  const Bottom({Key? key, required this.moves, required this.secondsElapsed, required this.shuffle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Moves',
                  style: kPassiveText,
                ),
                const SizedBox(height: 5),
                Text(
                  moves,
                  style: kBoldBigText,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Seconds',
                  style: kPassiveText,
                ),
                const SizedBox(height: 5),
                Text(
                  secondsElapsed,
                  style: kBoldBigText,
                ),
              ],
            ),
            InkWell(
              onTap: shuffle,
              child: const Icon(
                Icons.shuffle,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
