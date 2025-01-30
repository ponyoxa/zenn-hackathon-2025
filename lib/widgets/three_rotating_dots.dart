import 'package:flutter/material.dart';
import 'dart:math' as math;

class ThreeRotatingDots extends StatefulWidget {
  final Color color1;
  final Color color2;
  final Color color3;
  final double size;

  const ThreeRotatingDots({
    super.key,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.size,
  });

  @override
  State<ThreeRotatingDots> createState() => _ThreeRotatingDotsState();
}

class _ThreeRotatingDotsState extends State<ThreeRotatingDots>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        // 実際の回転半径を考慮したサイズ計算
        final dotSize = widget.size / 5;
        final orbitRadius = widget.size / 3;
        // 必要なスペースを確保するためのコンテナサイズ
        final containerSize = (orbitRadius * 2) + dotSize;

        return SizedBox(
          width: containerSize,
          height: containerSize,
          child: Stack(
            children: List.generate(3, (index) {
              return Positioned(
                left: containerSize / 2 -
                    dotSize / 2 +
                    orbitRadius *
                        math.cos(2 * math.pi * (index / 3) +
                            2 * math.pi * _controller.value),
                top: containerSize / 2 -
                    dotSize / 2 +
                    orbitRadius *
                        math.sin(2 * math.pi * (index / 3) +
                            2 * math.pi * _controller.value),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 0
                        ? widget.color1
                        : index == 1
                            ? widget.color2
                            : widget.color3,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
