import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      theme: ThemeData(useMaterial3: true),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _makeCircular = false;
  static var _scale = 1.0;
  static var _rotation = 0.0;
  Offset _position = Offset(0, 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tests Gesture'),
      ),
      body: Center(
        child: GestureDetector(
          onScaleUpdate: (details) {
            setState(() {
              _scale = details.scale;
              _rotation = details.rotation;
              _position = Offset(
                _position.dx + details.focalPointDelta.dx,
                _position.dy + details.focalPointDelta.dy,
              );
            });
          },
          onScaleEnd: (details) => setState(() {
            _scale = 1.0;
            _rotation = 0.0;
            _position = Offset(0, 0);
          }),
          onLongPress: () {
            setState(() {
              _makeCircular = !_makeCircular;
            });
          },
          child: Transform.scale(
            scale: _scale,
            child: Transform.rotate(
              angle: _rotation,
              child: Transform.translate(
                offset: _position,
                child: Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: _makeCircular
                      ? const CircleBorder()
                      : const RoundedRectangleBorder(),
                  child: Image.asset(
                    'assets/chat.jpg',
                    width: 300.0,
                    height: 300.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
