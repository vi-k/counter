import 'package:counter/counter_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Counter',
        theme: ThemeData(
          brightness: Brightness.dark,
          canvasColor: Colors.black,
          scaffoldBackgroundColor: Colors.black,
        ),
        home: const CounterPage(),
      );
}
