import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: CustomPaint(
        size: const Size(15, 15), // Desired size
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
      ..color = isSelected ? const Color(0xFF2892D7) : Colors.transparent
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = const Color(0xFFC4C4C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      const Radius.circular(4.0),
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
