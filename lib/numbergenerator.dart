import 'package:flutter/material.dart';

import 'numbergeneratorlogic.dart';
  

class NumberGenerator extends StatefulWidget {
  const NumberGenerator({Key? key}) : super(key: key);

  @override
  State<NumberGenerator> createState() => _NumberGeneratorState();
}

class _NumberGeneratorState extends State<NumberGenerator> {
  final genobject = NumberLogic();
  int num1 = 0;
  int num2 = 0;
  Stopwatch stopwatch = Stopwatch();

  void restart() {
    setState(() {
      genobject.counter = 0;
      genobject.corrects = [];
      genobject.incorrects = [];
      stopwatch.reset(); // Reset the stopwatch when the game is restarted
      startGame();
    });
  }

  void startGame() {
    setState(() {
      var randomnums = genobject.generateRandoms();
      num1 = randomnums[0];
      num2 = randomnums[1];
      if (genobject.counter == 0) {
        stopwatch.start(); // Start the stopwatch when the quiz starts
      }
    });
  }

  void choseAnswer(int answer) {
    setState(() {
      genobject.updateScores([num1, num2, answer]);
      if (genobject.counter <= 10) {
        startGame();
      } else {
        genobject.counter = 10;
        stopwatch.stop(); // Stop the stopwatch when the quiz ends
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Generator'),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.width,
        color: const Color(0x0ff1f1f1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            genobject.counter < 10
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40)),
                        onPressed: () => choseAnswer(num1),
                        child: Text(
                          '$num1',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(100, 40)),
                        onPressed: () => choseAnswer(num2),
                        child: Text(
                          '$num2',
                          style: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            genobject.counter == 10
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Correct: ${genobject.corrects.length}/10',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Incorrect: ${genobject.incorrects.length}/10',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Time: ${stopwatch.elapsed.inSeconds} seconds',
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            Text(
              'Your Score: ${genobject.corrects.length}/${genobject.counter}',
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            genobject.counter == 10
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(100, 40),
                    ),
                    onPressed: () {
                      restart();
                    },
                    child: const Text(
                      'Restart',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
