import 'package:counter_slider/counter_slider.dart';
import 'package:counter_slider/flutter_form.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const p0 = MyHomePage();

const p1 = FormPage(
  title: 'Title',
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: p0,
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
              slideFactor: 1,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 300,
              height: 120,
              borderSize: 4,
              buttonBorderGap: 4,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 300,
              height: 48,
              slideFactor: 0.3,
              borderSize: 6,
              buttonBorderGap: 0,
            ),
            const SizedBox(height: 48),
            const CounterSlider(
              width: 96,
              height: 32,
              slideFactor: 4,
              buttonBorderGap: 0,
              borderSize: 0,
            ),
            const SizedBox(height: 48),
            Slider(value: 0.5, onChanged: (_) {}, min: -5, max: 100),
          ],
        ),
      ),
    );
  }
}
