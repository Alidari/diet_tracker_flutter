import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            CustomPaint(
              size: Size(200, 200),
              painter: BackgroundPainter(color: Colors.blue),
            ),
            CustomPaint(
              size: Size(200, 200),
              painter: BackgroundPainter(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class BackgroundPainter extends CustomPainter {
  final Color color;

  BackgroundPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = color;
    Path path = Path();

    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 4, 0, size.width / 2, size.height / 4);
    path.quadraticBezierTo(
        size.width * 3 / 4, size.height / 2, size.width, size.height * 3 / 4);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
