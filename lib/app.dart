import 'package:flutter/material.dart';

import 'numbergenerator.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NumberGenerator());
  }
}
