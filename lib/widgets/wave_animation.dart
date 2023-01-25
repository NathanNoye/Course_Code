import 'dart:math';

import 'package:flutter/material.dart';

class WaveAnimation extends StatefulWidget {
  Color waveColor;
  int speed;
  int height;
  double offset;
  bool? allowSeeThrough;

  WaveAnimation({
    required this.waveColor,
    required this.speed,
    required this.height,
    required this.offset,
    this.allowSeeThrough,
  });

  @override
  State<WaveAnimation> createState() => _WaveAnimationState();
}

class _WaveAnimationState extends State<WaveAnimation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.speed))
      ..forward()
      ..repeat()
      ..addListener(() {
        setState(() {});
      });
  }

  double positionX = 0;
  double positionY = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Draggable(
        onDragUpdate: (details) {
          setState(() {
            positionY = details.globalPosition.dy;
            positionX = details.globalPosition.dx;
          });
        },
        feedback: Container(),
        child: CustomPaint(
          size: Size(double.infinity, double.infinity),
          painter: WavePainter(
            waveAnimation: _animationController,
            waveColor: widget.waveColor,
            height: widget.height,
            offset: widget.offset,
            allowSeeThrough: widget.allowSeeThrough,
            positionY: positionY,
            positionX: positionX,
          ),
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final Animation<double> waveAnimation;
  final Color waveColor;
  final double offset;
  final int height;
  bool? allowSeeThrough;
  double positionX;
  double positionY;

  WavePainter({
    required this.waveAnimation,
    required this.waveColor,
    required this.offset,
    required this.height,
    this.allowSeeThrough,
    required this.positionX,
    required this.positionY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();

    for (double i = 0.0; i <= size.width; i++) {
      path.lineTo(
          i,
          sin((i / size.width * 2 * pi) +
                  (waveAnimation.value * 2 * pi) +
                  offset) *
              height);
    }
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();

    if (allowSeeThrough == true) {
      Paint wavePaint = Paint()..color = waveColor;
      canvas.drawPath(
        Path.combine(
          PathOperation.difference,
          path,
          Path()
            ..addOval(Rect.fromCircle(
                center: Offset(positionX, positionY - offset), radius: 50))
            ..close(),
        ),
        wavePaint,
      );
    } else {
      Paint wavePaint = Paint()..color = waveColor;
      canvas.drawPath(path, wavePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
