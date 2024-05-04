import 'package:flutter/cupertino.dart';

class OvalBalon extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Widget child;

  OvalBalon({required this.width, required this.height, required this.color, required this.child});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BalonClipper(),
      child: Container(
        width: width,
        height: height,
        color: color,
        child: child,
      ),
    );
  }
}

class BalonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, size.height); // Başlangıç noktası
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - 30); // Sağ köşe
    path.lineTo(size.width, 0); // Üst sağ köşe
    path.quadraticBezierTo(
        size.width, 0, size.width - 30, 0); // Üst orta sağ
    path.lineTo(10, 0); // Üst orta sol
    path.quadraticBezierTo(0, 0, 0, 10); // Üst sol köşe
    path.lineTo(0, size.height - 20); // Alt sol köşe
    path.quadraticBezierTo(
        0, size.height, 20, size.height); // Alt orta sol
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
