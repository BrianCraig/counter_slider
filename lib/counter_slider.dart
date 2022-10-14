import 'dart:math' show pi;

import 'package:flutter/material.dart';

Offset _onX(_CounterSliderState state) {
  return Offset(
      state.change.dx
          .clamp(-state._maxButtonSeparation, state._maxButtonSeparation),
      0);
}

Offset _onY(_CounterSliderState state) {
  return Offset(0, state.change.dy.clamp(0, state.widget.height * 0.8));
}

enum _LockedOn {
  X(_onX),
  Y(_onY);

  const _LockedOn(this.lockManipulation);

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
    this.slideFactor = .4,
  }) : assert(slideFactor >= 0.0);

  final double width, height;

  final double buttonRatio, slideFactor;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider> {
  int value = 0;

  Offset change = Offset.zero;

  _LockedOn lockedOn = _LockedOn.X;

  double _buttonSize = 0,
      _buttonGap = 0,
      _maxButtonSeparation = 0,
      _halfWidth = 0;

  void calculateDimensions() {
    _buttonSize = widget.buttonRatio * widget.height;
    _buttonGap = (widget.height - _buttonSize) / 2;
    _halfWidth = (widget.width / 2);
    _maxButtonSeparation = (_halfWidth * (1 + widget.slideFactor) -
        (_buttonSize / 2) -
        _buttonGap);
  }

  @override
  void initState() {
    super.initState();
    calculateDimensions();
  }

  @override
  void didUpdateWidget(covariant CounterSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    calculateDimensions();
  }

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

  void reset() {
    setState(() {
      value = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    var clamped = lockedOn.lockManipulation(this);
    double xStatus = clamped.dx / _maxButtonSeparation;
    double x = xStatus * _halfWidth * (widget.slideFactor);
    double y = clamped.dy.clamp(0, widget.height * .2);
    CrossFadeState cs =
        y < clamped.dy ? CrossFadeState.showSecond : CrossFadeState.showFirst;
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
                        BorderRadius.circular(_buttonSize / 2 + _buttonGap),
                    border: Border.all(
                        color: const Color.fromARGB(28, 0, 0, 0),
                        width: _buttonGap - 2),
                    color: const Color.fromARGB(28, 0, 0, 0)),
                child: SizedBox(
                  width: widget.width - (_buttonGap * 2) + 4,
                  height: widget.height - (_buttonGap * 2) + 4,
                  child: AnimatedCrossFade(
                    firstChild: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints.tightFor(
                                width: _buttonSize, height: _buttonSize),
                            splashRadius: _buttonSize * (4 / 8),
                            onPressed: decrement,
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.grey,
                            ),
                          ),
                          IconButton(
                            constraints: BoxConstraints.tightFor(
                                width: _buttonSize, height: _buttonSize),
                            splashRadius: _buttonSize * (4 / 8),
                            onPressed: increment,
                            icon: const Icon(
                              Icons.add,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    secondChild: Align(
                      alignment: Alignment.center,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints.tightFor(
                            width: _buttonSize, height: _buttonSize),
                        splashRadius: _buttonSize * (4 / 8),
                        onPressed: decrement,
                        icon: const Icon(
                          Icons.restart_alt,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    crossFadeState: cs,
                    duration: const Duration(milliseconds: 280),
                  ),
                ),
              ),
            ),
            Positioned(
              left: widget.width / 2 - _buttonSize / 2 + clamped.dx,
              top: _buttonGap + clamped.dy,
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
                          ? _LockedOn.Y
                          : _LockedOn.X;
                    }
                    change += details.delta;
                  });
                },
                onPanEnd: (details) {
                  if (xStatus <= -0.3) {
                    decrement();
                  } else if (xStatus >= 0.3) {
                    increment();
                  } else if (cs == CrossFadeState.showSecond) {
                    reset();
                  }
                  setState(() {
                    change = Offset.zero;
                  });
                },
                child: MouseRegion(
                  cursor: SystemMouseCursors.grab,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_buttonSize / 2),
                      color: const Color.fromARGB(200, 255, 255, 255),
                    ),
                    child: SizedBox(
                      width: _buttonSize,
                      height: _buttonSize,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '$value',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: widget.height / 2,
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
