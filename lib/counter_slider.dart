import 'dart:math' show pi;

import 'package:flutter/material.dart';

Offset _onX(_CounterSliderState state) {
  return Offset(state.change.dx.clamp(-state.maxButtonSeparation, state.maxButtonSeparation), 0);
}

Offset _onY(_CounterSliderState state) {
  double max =
      state.widget.height * 0.5 / (1 + state.widget.slideFactor);
  return Offset(0, state.change.dy.clamp(0, max));
}

enum LockedOn {
  X(_onX),
  Y(_onY);

  const LockedOn(this.lockManipulation);

  final Offset Function(_CounterSliderState state) lockManipulation;
}

bool between(double x, double min, double max) {
  return (x >= min) && (x <= max);
}

class CounterSlider extends StatefulWidget {
  const CounterSlider({
    super.key,
    required this.width,
    required this.height,
    this.buttonRatio = .85,
    this.slideFactor = .4
  }) : assert(slideFactor >= 0.0 && slideFactor <= 1.0);

  final double width, height;

  final double buttonRatio, slideFactor;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider> {
  int value = 0;

  Offset change = Offset.zero;

  LockedOn lockedOn = LockedOn.X;

  late double buttonSize = widget.buttonRatio * widget.height;

  late double buttonGap = (widget.height - buttonSize) / 2;

  late double maxButtonSeparation = ((widget.width / 2) * (1 + widget.slideFactor) - (buttonSize / 2) - buttonGap);

  @override
  Widget build(BuildContext context) {
    var clamped = lockedOn.lockManipulation(this);
    var x = clamped.dx / maxButtonSeparation * (widget.width/2) * (widget.slideFactor);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: widget.width,
        height: widget.height,
      ),
      child: Container(
        color: const Color.fromARGB(255, 255, 165, 165),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: x,
              top: clamped.dy * widget.slideFactor,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(buttonSize/2),
                    color: const Color.fromARGB(28, 0, 0, 0)),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                ),
              ),
            ),
            Positioned(
              left: widget.width / 2 - buttonSize / 2 + clamped.dx,
              top: buttonGap + clamped.dy,
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    // change = details.localPosition;
                  });
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    if (change == Offset.zero) {
                      lockedOn = between(details.delta.direction,
                              (pi * 0.5 / 4), ((pi * 3.5 / 4)))
                          ? LockedOn.Y
                          : LockedOn.X;
                    }
                    change += details.delta;
                  });
                },
                onPanEnd: (details) {
                  setState(() {
                    change = Offset.zero;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(buttonSize/2 - buttonGap),
                    color: const Color.fromARGB(123, 0, 0, 0),
                  ),
                  child: SizedBox(
                    width: buttonSize,
                    height: buttonSize,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
