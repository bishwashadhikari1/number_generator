import 'dart:math';

class NumberLogic {
  int counter = 0;
  List<int> corrects = [];
  List<int> incorrects = [];

  List<int> generateRandoms() {
    List<int> rans = [];
    rans.add(Random().nextInt(100));
    rans.add(0);
    while (rans[1] == 0) {
      int temp = Random().nextInt(100);
      if (temp != rans[0]) {
        rans[1] = temp;
      }
    }
    return rans;
  }

  List<dynamic> updateScores(List<int> listCheck) {
    bool correct = false;
    counter = counter + 1;
    if (listCheck[0] == listCheck[2] && listCheck[0] > listCheck[1]) {
      corrects.add(listCheck[0]);
      correct = true;
    } else if (listCheck[1] == listCheck[2] && listCheck[1] > listCheck[0]) {
      corrects.add(listCheck[1]);
      correct = true;
    } else if (listCheck[0] == listCheck[2]) {
      incorrects.add(listCheck[1]);
    } else if (listCheck[1] == listCheck[2]) {
      incorrects.add(listCheck[0]);
    }
    if (counter != 10) {
      return [
        correct,
        corrects.isNotEmpty ? corrects.last : null,
        incorrects.isNotEmpty ? incorrects.last : null
      ];
    }
    return [true, -99, -99];
  }
}
