import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: CustomPaint(
        size: Size(15, 15), // Desired size
        painter: _CheckboxPainter(isSelected: value),
      ),
    );
  }
}

class _CheckboxPainter extends CustomPainter {
  final bool isSelected;

  _CheckboxPainter({required this.isSelected});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isSelected ? Color(0xFF2892D7) : Colors.transparent
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Color(0xFFC4C4C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(4.0),
    );

    canvas.drawRRect(rect, paint);
    canvas.drawRRect(rect, borderPaint);

    if (isSelected) {
      final checkPaint = Paint()
        ..color = Colors.white
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;

      final path = Path()
        ..moveTo(size.width * 0.2, size.height * 0.5)
        ..lineTo(size.width * 0.45, size.height * 0.75)
        ..lineTo(size.width * 0.8, size.height * 0.25);

      canvas.drawPath(path, checkPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
