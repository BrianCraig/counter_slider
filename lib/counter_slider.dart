import 'package:flutter/material.dart';

class CounterSlider extends StatefulWidget {
  const CounterSlider({super.key, required this.width, required this.height});

  final double width, height;

  @override
  State<CounterSlider> createState() => _CounterSliderState();
}

class _CounterSliderState extends State<CounterSlider> {
  int value = 0;

  double get bottomSize {
    return widget.height * .85;
  }

  @override
  Widget build(BuildContext context) {
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
              left: 0,
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
              left: widget.width / 2 - bottomSize / 2,
              top: widget.height / 2 - bottomSize / 2,
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
          ],
        ),
      ),
    );
  }
}
