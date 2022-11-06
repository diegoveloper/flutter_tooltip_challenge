import 'package:flutter/material.dart';

class Screen2 extends StatefulWidget {
  const Screen2({super.key});

  @override
  State<Screen2> createState() => _Screen2State();
}

class _Screen2State extends State<Screen2> {
  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int indexShow = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(
          Colors.primaries.length,
          (index) => _Item(
            index: index,
            color: Colors.primaries[index],
            show: index == indexShow,
            showCallback: () {
              ///Si el item esta seleccionado, lo deseleccionamos
              if (index == indexShow) {
                indexShow = -1;
              } else {
                indexShow = index;
              }
              setState(() {});
            },
          ),
        ),
      ),
    );
  }
}

///Item list
class _Item extends StatelessWidget {
  const _Item(
      {required this.index,
      required this.color,
      required this.show,
      required this.showCallback});

  final int index;
  final bool show;
  final Color color;
  final VoidCallback showCallback;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [
        //List tile
        Container(
          height: kToolbarHeight,
          color: color,
          child: ListTile(
            title: Text('Item $index'),
            onTap: showCallback,
          ),
        ),

        //Tooltip
        if (show)
          Positioned(
            top: (index == 0)

                ///Tamaño cuando el item esta en la primera posicion
                ? (kToolbarHeight * .3 + 5.5)

                ///Tamaño del resto de los items
                : (kToolbarHeight * .6) * -3,
            bottom: (index == 0) ? 5 : kToolbarHeight + 5,
            child: GestureDetector(
              onTap: () {
                print('ON TAP');
              },
              child: _TooltipWidget(index: index),
            ),
          ),
      ],
    );
  }
}

class _TooltipWidget extends StatelessWidget {
  const _TooltipWidget({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TooltipPainter(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        alignment: Alignment.centerLeft,
        height: kToolbarHeight,
        width: 200,
        child: Text(
          'Tooltip: item $index',
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class _TooltipPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..moveTo(size.width * .45, size.height)
      ..lineTo(size.width * .55, size.height)
      ..lineTo(size.width * .5, size.height + 5)
      ..lineTo(size.width * .45, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
