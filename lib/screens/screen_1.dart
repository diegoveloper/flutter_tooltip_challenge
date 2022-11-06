import 'package:flutter/material.dart';

class Screen1 extends StatefulWidget {
  const Screen1({super.key});

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemBuilder: (context, index) {
          final color = Colors.primaries[index % Colors.primaries.length];
          return PopupMenuButton<int>(
            position: PopupMenuPosition.over,
            itemBuilder: (context) => [
              PopupMenuItem(
                value: index,
                child: Material(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Center(
                      child: Text('Tooltip para $index'),
                    ),
                  ),
                ),
              ),
            ],
            child: ListTile(
              tileColor: color,
              title: Text('Elemento $index'),
            ),
          );
        },
      ),
    );
  }
}
