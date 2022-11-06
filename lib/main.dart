import 'package:flutter/material.dart';
import 'package:flutter_tooltip_challenge/screens/screen_1.dart';
import 'package:flutter_tooltip_challenge/screens/screen_2.dart';
import 'package:flutter_tooltip_challenge/screens/screen_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tooltip demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void goToPage(BuildContext context, Widget screen) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tooltip Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: const Text('1er intento'),
              onPressed: () => goToPage(context, const Screen1()),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: const Text('2do intento'),
              onPressed: () => goToPage(context, const Screen2()),
            ),
            MaterialButton(
              color: Theme.of(context).primaryColor,
              child: const Text('3er intento'),
              onPressed: () => goToPage(context, const Screen3()),
            ),
          ],
        ),
      ),
    );
  }
}
