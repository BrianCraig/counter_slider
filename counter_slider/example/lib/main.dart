import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/widgets.dart';

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  int value = 0;

  void setValue(int newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterSlider(
      value: value,
      setValue: setValue,
      minValue: 0,
      maxValue: 4,
      width: 240,
      height: 80,
      slideFactor: 1.4,
    );
  }
}
