import 'dart:math' show pi;

import 'package:flutter/material.dart';

Offset _onX(_CounterSliderState state) {
  return Offset(
      state.change.dx
          .clamp(-state.maxButtonSeparation, state.maxButtonSeparation),
      0);
}

Offset _onY(_CounterSliderState state) {
  return Offset(0, state.change.dy.clamp(0, state.widget.height * 0.8));
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
  const CounterSlider(
      {super.key,
      required this.width,
      required this.height,
      this.buttonRatio = .85,
      this.slideFactor = .4})
      : assert(slideFactor >= 0.0);

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

  late double maxButtonSeparation =
      ((widget.width / 2) * (1 + widget.slideFactor) -
          (buttonSize / 2) -
          buttonGap);

  void decrement() {
    setState(() {
      value--;
    });
  }

  void increment() {
    setState(() {
      value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var clamped = lockedOn.lockManipulation(this);
    double xStatus = clamped.dx / maxButtonSeparation;
    double x = xStatus * (widget.width / 2) * (widget.slideFactor);
    double y = clamped.dy.clamp(0, widget.height * .2);
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: widget.width,
        height: widget.height,
      ),
      child: Container(
        // color: const Color.fromARGB(255, 255, 165, 165),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: x,
              top: y,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.circular(buttonSize / 2 + buttonGap),
                    border: Border.all(
                        color: const Color.fromARGB(28, 0, 0, 0),
                        width: buttonGap - 2),
                    color: const Color.fromARGB(28, 0, 0, 0)),
                child: SizedBox(
                  width: widget.width - (buttonGap * 2) + 4,
                  height: widget.height - (buttonGap * 2) + 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          constraints: BoxConstraints.tightFor(
                              width: buttonSize, height: buttonSize),
                          splashRadius: buttonSize * (3 / 8),
                          onPressed: decrement,
                          icon: const Icon(
                            Icons.remove,
                            color: Colors.grey,
                          ),
                        ),
                        IconButton(
                          constraints: BoxConstraints.tightFor(
                              width: buttonSize, height: buttonSize),
                          splashRadius: buttonSize * (3 / 8),
                          onPressed: increment,
                          icon: const Icon(
                            Icons.add,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: widget.width / 2 - buttonSize / 2 + clamped.dx,
              top: buttonGap + clamped.dy,
              child: GestureDetector(
                onTap: increment,
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
                  if(xStatus <= -0.3){
                    decrement();
                  } else if(xStatus >= 0.3){
                    increment();
                  }
                  setState(() {
                    change = Offset.zero;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(buttonSize / 2),
                      color: const Color.fromARGB(123, 0, 0, 0),
                    ),
                    child: SizedBox(
                      width: buttonSize,
                      height: buttonSize,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$value',
                          style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 48,
                          ),
                        ),
                      ),
                    ),
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
