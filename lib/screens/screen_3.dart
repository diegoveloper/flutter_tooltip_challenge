import 'package:flutter/material.dart';

class Screen3 extends StatefulWidget {
  const Screen3({super.key});

  @override
  State<Screen3> createState() => _Screen3State();
}

class _Screen3State extends State<Screen3> {
  OverlayEntry? entry;
  LayerLink? myLink;

  void removeTooltip() {
    entry?.remove();
    entry = null;
  }

  void showTooltip(int index, LayerLink link) {
    removeTooltip();
    // Lenguaje: Dart
    entry = OverlayEntry(
      builder: (context) {
        return Positioned(
          height: 100,
          width: 200,
          child: CompositedTransformFollower(
            link: link,
            showWhenUnlinked: false,
            followerAnchor: Alignment.bottomCenter,
            targetAnchor: Alignment.center,
            offset: const Offset(0, -40),
            child: Material(
              child: InkWell(
                onTap: () {
                  removeTooltip();
                },
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: FlutterLogo(
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context)!.insert(entry!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Usando 2 widgets en mitad de pantalla
      //   body: Column(
      //     children: [
      //       Expanded(
      //         child: Container(
      //           color: Colors.white,
      //         ),
      //       ),
      //       Expanded(
      //         child: Stack(
      //           children: [
      //             ListView.builder(
      //               itemCount: 30,
      //               itemBuilder: (context, index) {
      //                 return MyItem(
      //                     index: index,
      //                     onTap: (value) {
      //                       // Evitar Overlay en este caso
      //                       //showTooltip(index, value);
      //                       setState(() {
      //                         myLink = value;
      //                       });
      //                     });
      //               },
      //             ),

      //             // Follower
      //             // Para evitar que el Overlay se muestre encima del widget de arriba
      //             if (myLink != null)
      //               Positioned(
      //                 left: 0,
      //                 right: 0,
      //                 top: -40,
      //                 child: CompositedTransformFollower(
      //                   link: myLink!,
      //                   showWhenUnlinked: false,
      //                   child: const FlutterLogo(
      //                     size: 50,
      //                   ),
      //                 ),
      //               ),
      //           ],
      //         ),
      //       )
      //     ],
      //   ),
      // );

      // Usando solo un widget completo de lista de elementos
      // Aquí, usar Overlay es válido

      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            30,
            (index) => MyItem(
              index: index,
              onTap: (value) => showTooltip(index, value),
            ),
          ),
        ),
      ),
    );
  }
}

class MyItem extends StatefulWidget {
  const MyItem({
    required this.index,
    required this.onTap,
    super.key,
  });

  final int index;
  final ValueChanged<LayerLink> onTap;

  @override
  State<MyItem> createState() => _MyItemState();
}

class _MyItemState extends State<MyItem> {
  final layerLink = LayerLink();

  @override
  Widget build(BuildContext context) {
    final color = Colors.primaries[widget.index % Colors.primaries.length];
    return CompositedTransformTarget(
      link: layerLink,
      child: ListTile(
        tileColor: color,
        title: Text('Elemento ${widget.index}'),
        onTap: () => widget.onTap(layerLink),
      ),
    );
  }
}
