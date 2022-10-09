import 'dart:math' show pi;

import 'package:flutter/material.dart';

Offset _onX(_CounterSliderState state)  {
  return Offset(state.change.dx, 0);
}

Offset _onY(_CounterSliderState state)  {
  return Offset(0, state.change.dy.clamp(0, double.infinity));
}

enum LockedOn{
  X(_onX), Y(_onY);

  const LockedOn(this.lockManipulation);

  final Offset Function(_CounterSliderState state) lockManipulation;
}

bool between (double x,double min, double max){
  return (x >= min) && (x <= max);
}

class CounterSlider extends StatefulWidget {
  const CounterSlider({super.key, required this.width, required this.height});

  final double width, height;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider> {
  int value = 0;

  Offset change = Offset.zero;

  LockedOn lockedOn = LockedOn.X;

  static double slideFactor = 0.4;

  double get bottomSize {
    return widget.height * .85;
  }

  @override
  Widget build(BuildContext context) {
    var clamped = lockedOn.lockManipulation(this);
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
              left: clamped.dx * slideFactor,
              top: clamped.dy * slideFactor,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: const Color.fromARGB(28, 0, 0, 0)),
                child: SizedBox(
                  width: widget.width,
                  height: widget.height,
                ),
              ),
            ),
            Positioned(
              left: widget.width / 2 - bottomSize / 2 + clamped.dx,
              top: widget.height / 2 - bottomSize / 2 + clamped.dy,
              child: GestureDetector(
                onPanStart: (details) {
                  setState(() {
                    // change = details.localPosition;
                  });
                },
                onPanUpdate: (DragUpdateDetails details) {
                  setState(() {
                    if(change == Offset.zero){
                      lockedOn = between(details.delta.direction, (pi* 1/4), ((pi* 3/4))) ? LockedOn.Y : LockedOn.X;
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
                    borderRadius: BorderRadius.circular(200),
                    color: const Color.fromARGB(123, 0, 0, 0),
                  ),
                  child: SizedBox(
                    width: bottomSize,
                    height: bottomSize,
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
