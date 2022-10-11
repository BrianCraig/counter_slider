import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hi"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CounterSlider(
              width: 256,
              height: 64,
              buttonRatio: 0.9,
              slideFactor: 0,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 300,
              height: 120,
              buttonRatio: 0.95,
              slideFactor: 0.4,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 300,
              height: 120,
              buttonRatio: 0.8,
              slideFactor: 0.4,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 300,
              height: 120,
              buttonRatio: 0.8,
              slideFactor: 0.4,
            ),
            const SizedBox(height: 48),
            Slider(value: 0.5, onChanged: (_){}, min: -5, max: 100),
          ],
        ),
      ),
    );
  }
}
