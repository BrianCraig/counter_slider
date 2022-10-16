library counter_slider;

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
    required this.value,
    required this.setValue,
    required this.width,
    required this.height,
    this.minValue = double.negativeInfinity,
    this.maxValue = double.infinity,
    this.buttonBorderGap = 2,
    this.borderSize = 2,
    this.slideFactor = 1.4,
  })  : assert(slideFactor >= 0.0),
        assert(width >= 96),
        assert(height >= 32);

  final int value;
  final void Function(int) setValue;

  final double minValue, maxValue;

  final double width, height;

  final double borderSize, slideFactor, buttonBorderGap;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider> {
  Offset change = Offset.zero;

  _LockedOn lockedOn = _LockedOn.X;

  double _buttonSize = 0,
      _buttonGap = 0,
      _maxButtonSeparation = 0,
      _halfWidth = 0,
      _buttonRadius = 0;

  void calculateDimensions() {
    _buttonGap = widget.borderSize + widget.buttonBorderGap;
    _buttonSize = widget.height - (_buttonGap * 2);
    _buttonRadius = _buttonSize / 2;
    _halfWidth = (widget.width / 2);
    _maxButtonSeparation =
        _halfWidth * widget.slideFactor - _buttonRadius - _buttonGap;
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
    if (widget.minValue <= widget.value - 1) {
      widget.setValue(widget.value - 1);
    }
  }

  void increment() {
    if (widget.maxValue >= widget.value + 1) {
      widget.setValue(widget.value + 1);
    }
  }

  void reset() {
    widget.setValue(0);
  }

  @override
  Widget build(BuildContext context) {
    var clamped = lockedOn.lockManipulation(this);
    double xStatus = clamped.dx / _maxButtonSeparation;
    double x = xStatus * _halfWidth * (widget.slideFactor - 1);
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
                      BorderRadius.all(Radius.circular(widget.height)),
                  border: Border.all(
                      color: Theme.of(context).hintColor,
                      width: widget.borderSize),
                ),
                child: SizedBox(
                  width: widget.width - (widget.borderSize * 2),
                  height: widget.height - (widget.borderSize * 2),
                  child: AnimatedCrossFade(
                    firstChild: Padding(
                      padding: EdgeInsets.all(widget.buttonBorderGap),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _MyButton(
                            icon: Icons.remove,
                            onClick: decrement,
                            size: _buttonSize,
                          ),
                          _MyButton(
                            icon: Icons.add,
                            onClick: increment,
                            size: _buttonSize,
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
              left: _halfWidth - _buttonRadius + clamped.dx,
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
                      borderRadius: BorderRadius.circular(_buttonRadius),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: SizedBox(
                      width: _buttonSize,
                      height: _buttonSize,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          '${widget.value}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSecondary,
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

class _MyButton extends StatelessWidget {
  const _MyButton(
      {required this.icon,
      required this.onClick,
      required this.size});

  final IconData icon;
  final void Function() onClick;
  final double size;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: SizedBox(
        height: size,
        width: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).hoverColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
          ),
        ),
      ),
    );
  }
}