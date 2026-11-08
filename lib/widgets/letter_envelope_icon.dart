import 'package:flutter/material.dart';

/// A reusable envelope whose paper color is supplied by [color].
class LetterEnvelopeIcon extends StatelessWidget {
  const LetterEnvelopeIcon({
    super.key,
    required this.color,
    this.width = 70,
    this.height = 46,
  });

  final Color color;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: '편지',
      image: true,
      child: CustomPaint(
        key: ValueKey(color),
        size: Size(width, height),
        painter: _EnvelopePainter(color),
      ),
    );
  }
}

class _EnvelopePainter extends CustomPainter {
  const _EnvelopePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final bodyPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawRect(Offset.zero & size, bodyPaint);

    final foldPaint = Paint()
      ..color = Colors.white.withOpacity(0.58)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.65
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fold = Path()
      ..moveTo(0.5, 0.5)
      ..lineTo(size.width / 2, size.height * 0.54)
      ..lineTo(size.width - 0.5, 0.5);
    canvas.drawPath(fold, foldPaint);
  }

  @override
  bool shouldRepaint(covariant _EnvelopePainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
