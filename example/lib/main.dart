import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const ExampleApp());
}

const p0 = MyHomePage();

Map<String, MaterialColor> colors = {
  "red": Colors.red,
  "pink": Colors.pink,
  "purple": Colors.purple,
  "deepPurple": Colors.deepPurple,
  "indigo": Colors.indigo,
  "blue": Colors.blue,
  "lightBlue": Colors.lightBlue,
  "cyan": Colors.cyan,
  "teal": Colors.teal,
  "green": Colors.green,
  "lightGreen": Colors.lightGreen,
  "lime": Colors.lime,
  "yellow": Colors.yellow,
  "amber": Colors.amber,
  "orange": Colors.orange,
  "deepOrange": Colors.deepOrange,
  "brown": Colors.brown,
  "blueGrey": Colors.blueGrey,
};

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  MaterialColor primary = Colors.blue, secondary = Colors.cyan;
  bool darkMode = false;
  int value = 0;

  void setValue(int newValue) {
    setState(() {
      value = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Slider Demo',
      themeMode: darkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: primary,
          secondary: secondary,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          primary: primary,
          secondary: secondary,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Counter Slider Demo"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Primary color'),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                isExpanded: true,
                value: primary,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: colors.entries
                    .map(
                      (entry) => DropdownMenuItem(
                        value: entry.value,
                        child: Text("${entry.key} Theme"),
                      ),
                    )
                    .toList(),
                onChanged: (MaterialColor? primary) {
                  setState(() {
                    this.primary = primary!;
                  });
                },
              ),
              DropdownButtonFormField(
                decoration: const InputDecoration(
                  label: Text('Secondary color'),
                  contentPadding: EdgeInsets.all(8.0),
                ),
                isExpanded: true,
                value: secondary,
                icon: const Icon(Icons.keyboard_arrow_down),
                items: colors.entries
                    .map(
                      (entry) => DropdownMenuItem(
                        value: entry.value,
                        child: Text("${entry.key} Theme"),
                      ),
                    )
                    .toList(),
                onChanged: (MaterialColor? secondary) {
                  setState(() {
                    this.secondary = secondary!;
                  });
                },
              ),
              ListTile(
                leading: Switch(
                  value: darkMode,
                  onChanged: (bool? darkMode) {
                    setState(() {
                      this.darkMode = darkMode!;
                    });
                  },
                ),
                title: const Text(
                  'Dark mode',
                ),
              ),
              separatorWidget,
              Center(
                child: CounterSlider(
                  value: value,
                  setValue: setValue,
                  width: 256,
                  height: 64,
                  slideFactor: 1.4,
                ),
              ),
              separatorWidget,
              separatorWidget,
              separatorWidget,
              const MaterialInputs(),
              const DebugColors(),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialInputs extends StatefulWidget {
  const MaterialInputs({super.key});

  @override
  State<MaterialInputs> createState() => _MaterialInputsState();
}

class _MaterialInputsState extends State<MaterialInputs> {
  bool switchState = false;
  bool checkbox = false;

  void setSwitch(bool? newValue) {
    setState(() {
      switchState = newValue!;
    });
  }

  void setCheckbox(bool? newValue) {
    setState(() {
      checkbox = newValue!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Switch(value: switchState, onChanged: setSwitch),
        separatorWidget,
        Checkbox(value: checkbox, onChanged: setCheckbox)
      ],
    );
  }
}

class DebugColors extends StatelessWidget {
  const DebugColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ColorDebugger(
          name: 'primaryColor',
          color: Theme.of(context).primaryColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.background',
          color: Theme.of(context).colorScheme.background,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.primary',
          color: Theme.of(context).colorScheme.primary,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.onPrimary',
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.secondary',
          color: Theme.of(context).colorScheme.secondary,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.onSecondary',
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'canvasColor',
          color: Theme.of(context).canvasColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'cardColor',
          color: Theme.of(context).cardColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'dialogBackgroundColor',
          color: Theme.of(context).dialogBackgroundColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'disabledColor',
          color: Theme.of(context).disabledColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'dividerColor',
          color: Theme.of(context).dividerColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'colorScheme.error',
          color: Theme.of(context).colorScheme.error,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'focusColor',
          color: Theme.of(context).focusColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'highlightColor',
          color: Theme.of(context).highlightColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'hintColor',
          color: Theme.of(context).hintColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'hoverColor',
          color: Theme.of(context).hoverColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'indicatorColor',
          color: Theme.of(context).indicatorColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'primaryColorDark',
          color: Theme.of(context).primaryColorDark,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'primaryColorLight',
          color: Theme.of(context).primaryColorLight,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'scaffoldBackgroundColor',
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'secondaryHeaderColor',
          color: Theme.of(context).secondaryHeaderColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'shadowColor',
          color: Theme.of(context).shadowColor,
        ),
        separatorWidget,
        ColorDebugger(
          name: 'splashColor',
          color: Theme.of(context).splashColor,
        ),
      ],
    );
  }
}

const separatorWidget = SizedBox(
  height: 8.0,
  width: 8.0,
);

class ColorDebugger extends StatelessWidget {
  const ColorDebugger({
    Key? key,
    required this.color,
    required this.name,
  }) : super(key: key);

  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    final String desc = 'Theme.of(context).$name';
    return GestureDetector(
      onTap: () => Clipboard.setData(ClipboardData(text: desc)),
      child: Row(children: [
        Container(
          height: 32,
          width: 32,
          color: color,
        ),
        separatorWidget,
        Text(desc),
      ]),
    );
  }
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
            CounterSlider(
              value: 1,
              setValue: (_) {},
              width: 256,
              height: 64,
              slideFactor: 1,
            ),
            const SizedBox(height: 48),
            CounterSlider(
              value: 1,
              setValue: (_) {},
              width: 300,
              height: 120,
              borderSize: 4,
              buttonBorderGap: 4,
            ),
            const SizedBox(height: 48),
            CounterSlider(
              value: 1,
              setValue: (_) {},
              width: 300,
              height: 48,
              slideFactor: 0.8,
              borderSize: 6,
              buttonBorderGap: 0,
            ),
            const SizedBox(height: 48),
            CounterSlider(
              value: 1,
              setValue: (_) {},
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
