import 'dart:convert';
import 'dart:ui';

import 'package:dakahlia_task/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CircularProgressFeddans extends StatefulWidget {
  final List image;
  final double value;
  final double max;
  const CircularProgressFeddans({
    super.key,
    required this.image,
    required this.value,
    required this.max,
  });

  @override
  State<CircularProgressFeddans> createState() =>
      _CircularProgressFeddansState();
}

class _CircularProgressFeddansState extends State<CircularProgressFeddans>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  @override
  void initState() {
    debugPrint('zaza image: ${widget.image}');
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _animation = CurvedAnimation(
      parent: Tween(begin: 0.0, end: widget.value / widget.max)
          .animate(_controller),
      curve: Curves.linear,
    )..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Image.memory(
            base64Decode(widget.image.join()),
            errorBuilder: (context, error, stackTrace) {
              return const Text('img null');
            },
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 30),
          child: CustomPaint(
            painter: CircularPainter(),
          ),
        ),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 30),
          child: CustomPaint(
            painter: CircularPainter(animationProgress: _animation.value),
          ),
        ),
      ],
    );
  }
}

class CircularPainter extends CustomPainter {
  final double? animationProgress;
  late final Color activeColor =
      animationProgress != null ? AppColors.barColor : AppColors.semiDarkGrey;

  CircularPainter({super.repaint, this.animationProgress});

  @override
  void paint(Canvas canvas, Size size) {
    double? animation1;
    double? animation2;
    double? animation3;
    if (animationProgress != null) {
      animation1 = animationProgress!.clamp(0.0, 0.33) * 3;
      animation2 = (animationProgress!.clamp(0.33, 0.66) - 0.33) * 3;
      animation3 = (animationProgress!.clamp(0.66, 1.0) - 0.66) * 3;
    }
    var paint = Paint()
      ..color = activeColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20;

    _drawFirstSegment(canvas, size, paint, animation1);
    if (animationProgress == null || animationProgress! > 0.33) {
      _drawSecondSegment(canvas, size, paint, animation2);
    }
    if (animationProgress == null || animationProgress! > 0.66) {
      _drawThirdSegment(canvas, size, paint, animation3);
    }
  }

  void _drawFirstSegment(
    Canvas canvas,
    Size size,
    Paint paint,
    double? progress,
  ) {
    var path = Path();
    path.moveTo(size.width * 0.1, size.height + 100);
    path.arcToPoint(
      Offset(size.width * 0.3, (size.height - 60)),
      radius: const Radius.circular(200),
      clockwise: true,
    );
    if (progress != null) {
      _drawSegmentWithAnimation(canvas, path, paint, progress);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  void _drawSecondSegment(
    Canvas canvas,
    Size size,
    Paint paint,
    double? progress,
  ) {
    var path = Path();
    path.moveTo(size.width * 0.31, size.height - 63);
    path.arcToPoint(
      Offset(size.width * 0.55, size.height - 90),
      radius: const Radius.circular(220),
      clockwise: true,
    );
    if (progress != null) {
      _drawSegmentWithAnimation(canvas, path, paint, progress);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  void _drawThirdSegment(
    Canvas canvas,
    Size size,
    Paint paint,
    double? progress,
  ) {
    var path = Path();
    path.moveTo(size.width * 0.56, size.height - 90);
    path.arcToPoint(
      Offset(size.width * 0.9, size.height + 100),
      radius: const Radius.circular(180),
      clockwise: true,
    );
    if (progress != null) {
      _drawSegmentWithAnimation(canvas, path, paint, progress);
    } else {
      canvas.drawPath(path, paint);
    }
  }

  _drawSegmentWithAnimation(
    Canvas canvas,
    Path path,
    Paint paint,
    double progress,
  ) {
    PathMetrics pathMetrics = path.computeMetrics();
    for (var pathMetric in pathMetrics) {
      Path extractPath = pathMetric.extractPath(
        0,
        pathMetric.length * progress,
      );
      canvas.drawPath(extractPath, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
