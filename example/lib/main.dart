import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class IDDarkMode {}

class IDPrimary {}

class IDSecondary {}

class IDDemoValue {}

class IDWidth {}

class IDHeight {}

class IDBorder {}

class IDSpacing {}

class ChangeNotifierValue<T, Y> extends ChangeNotifier {
  ChangeNotifierValue(T initialValue) : _value = initialValue;

  T _value;

  T get value => _value;

  set value(T newValue) {
    _value = newValue;
    notifyListeners();
  }

  void onChanged(T? newValue) {
    // ignore: null_check_on_nullable_type_parameter
    _value = newValue!;
    notifyListeners();
  }
}

typedef CNV<X, Y> = ChangeNotifierValue<X, Y>;

void main() {
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<bool, IDDarkMode>(false),
      ),
      ChangeNotifierProvider(
        create: (_) =>
            ChangeNotifierValue<MaterialColor, IDPrimary>(Colors.blue),
      ),
      ChangeNotifierProvider(
        create: (_) =>
            ChangeNotifierValue<MaterialColor, IDSecondary>(Colors.cyan),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<int, IDDemoValue>(0),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<bool, IDWidth>(true),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<bool, IDHeight>(true),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<double, IDWidth>(96),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<double, IDHeight>(32),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<int, IDBorder>(2),
      ),
      ChangeNotifierProvider(
        create: (_) => ChangeNotifierValue<int, IDSpacing>(2),
      ),
    ], child: const ExampleApp()),
  );
}

const exampleCode1 = '''
CounterSlider(
  value: value,
  setValue: setValue,
  width: 96,
  height: 32,
  slideFactor: 1,
)''';

const exampleCode2 = '''
CounterSlider(
  value: value,
  setValue: setValue,
  width: 96,
  height: 32,
  slideFactor: 1.6,
)''';

const exampleCode3 = '''
CounterSlider(
  value: value,
  setValue: setValue,
  minValue: 0,
  width: 240,
  height: 80,
  slideFactor: 1.4,
)''';

const exampleCode4 = '''
CounterSlider(
  value: value,
  setValue: setValue,
  minValue: 0,
  maxValue: 4,
  width: 240,
  height: 80,
  slideFactor: 1.4,
)''';

const exampleCode5 = '''
CounterSlider(
  value: value,
  setValue: setValue,
  width: 240,
  height: 64,
  slideFactor: 0.8,
)''';

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

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Slider Demo',
      themeMode: context.watch<CNV<bool, IDDarkMode>>().value
          ? ThemeMode.dark
          : ThemeMode.light,
      theme: ThemeData.from(
        colorScheme: ColorScheme.light(
          primary: context.watch<CNV<MaterialColor, IDPrimary>>().value,
          secondary: context.watch<CNV<MaterialColor, IDSecondary>>().value,
        ),
      ),
      darkTheme: ThemeData.from(
        colorScheme: ColorScheme.dark(
          primary: context.watch<CNV<MaterialColor, IDPrimary>>().value,
          secondary: context.watch<CNV<MaterialColor, IDSecondary>>().value,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Counter Slider Demo"),
        ),
        body: const Padding(
          padding: EdgeInsets.all(8.0),
          child: ExampleContent(),
        ),
      ),
    );
  }
}

class ExampleContent extends StatelessWidget {
  const ExampleContent({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text(
          'Settings',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        separatorWidget,
        DropdownButtonFormField(
          decoration: const InputDecoration(
            label: Text('Primary color'),
            contentPadding: EdgeInsets.all(8.0),
          ),
          isExpanded: true,
          value: context.watch<CNV<MaterialColor, IDPrimary>>().value,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: colors.entries
              .map(
                (entry) => DropdownMenuItem(
                  value: entry.value,
                  child: Text("${entry.key} Theme"),
                ),
              )
              .toList(),
          onChanged: context.watch<CNV<MaterialColor, IDPrimary>>().onChanged,
        ),
        DropdownButtonFormField(
          decoration: const InputDecoration(
            label: Text('Secondary color'),
            contentPadding: EdgeInsets.all(8.0),
          ),
          isExpanded: true,
          value: context.watch<CNV<MaterialColor, IDSecondary>>().value,
          icon: const Icon(Icons.keyboard_arrow_down),
          items: colors.entries
              .map(
                (entry) => DropdownMenuItem(
                  value: entry.value,
                  child: Text("${entry.key} Theme"),
                ),
              )
              .toList(),
          onChanged: context.watch<CNV<MaterialColor, IDSecondary>>().onChanged,
        ),
        ListTile(
          leading: Switch(
            value: context.watch<CNV<bool, IDDarkMode>>().value,
            onChanged: context.watch<CNV<bool, IDDarkMode>>().onChanged,
          ),
          title: const Text(
            'Dark mode',
          ),
        ),
        ListTile(
          leading: Switch(
            value: context.watch<CNV<bool, IDWidth>>().value,
            onChanged: context.watch<CNV<bool, IDWidth>>().onChanged,
          ),
          title: Row(
            children: [
              const Text(
                'Width',
              ),
              Expanded(
                child: Slider(
                  value: context.watch<CNV<double, IDWidth>>().value,
                  onChanged: context.watch<CNV<double, IDWidth>>().onChanged,
                  min: 96,
                  max: 300,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: Switch(
            value: context.watch<CNV<bool, IDHeight>>().value,
            onChanged: context.watch<CNV<bool, IDHeight>>().onChanged,
          ),
          title: Row(
            children: [
              const Text(
                'Height',
              ),
              Expanded(
                child: Slider(
                  value: context.watch<CNV<double, IDHeight>>().value,
                  onChanged: context.watch<CNV<double, IDHeight>>().onChanged,
                  min: 32,
                  max: 120,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: CounterSlider(
            value: context.watch<CNV<int, IDBorder>>().value,
            setValue: context.watch<CNV<int, IDBorder>>().onChanged,
            width: 96,
            height: 32,
            minValue: 0,
            maxValue: 8,
          ),
          title: const Text(
            'Border size',
          ),
        ),
        ListTile(
          leading: CounterSlider(
            value: context.watch<CNV<int, IDSpacing>>().value,
            setValue: context.watch<CNV<int, IDSpacing>>().onChanged,
            width: 96,
            height: 32,
            minValue: 0,
            maxValue: 8,
          ),
          title: const Text(
            'Button border gap',
          ),
        ),
        separatorWidget,
        Text(
          'Demo',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        separatorWidget,
        Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment(-0.9, -0.8),
                  colors: [
                    Color.fromRGBO(122, 122, 122, 0.2),
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromRGBO(122, 122, 122, 0.2),
                  ],
                  tileMode: TileMode.repeated,
                  stops: [0, 0.01, 0.5, 0.51]),
            ),
            constraints: BoxConstraints.loose(const Size(300, 120)),
            child: Center(
              child: CounterSlider(
                value: context.watch<CNV<int, IDDemoValue>>().value,
                setValue: context.watch<CNV<int, IDDemoValue>>().onChanged,
                width: context.watch<CNV<double, IDWidth>>().value,
                height: context.watch<CNV<double, IDHeight>>().value,
                borderSize:
                    context.watch<CNV<int, IDBorder>>().value.toDouble(),
                buttonBorderGap:
                    context.watch<CNV<int, IDSpacing>>().value.toDouble(),
              ),
            ),
          ),
        ),
        separatorWidget,
        SliderExample(
          title: 'Small counter',
          code: exampleCode1,
          generator: (value, setValue) => CounterSlider(
            value: value,
            setValue: setValue,
            width: 96,
            height: 32,
            slideFactor: 1,
          ),
        ),
        separatorWidget,
        SliderExample(
          title: 'Small counter that slides',
          code: exampleCode2,
          generator: (value, setValue) => CounterSlider(
            value: value,
            setValue: setValue,
            width: 96,
            height: 32,
            slideFactor: 1.6,
          ),
        ),
        separatorWidget,
        SliderExample(
          title: 'Big one, positive only',
          code: exampleCode3,
          generator: (value, setValue) => CounterSlider(
            value: value,
            setValue: setValue,
            minValue: 0,
            width: 240,
            height: 80,
            slideFactor: 1.4,
          ),
        ),
        separatorWidget,
        SliderExample(
          title: 'Range [0, 4]',
          code: exampleCode4,
          generator: (value, setValue) => CounterSlider(
            value: value,
            setValue: setValue,
            minValue: 0,
            maxValue: 4,
            width: 240,
            height: 80,
            slideFactor: 1.4,
          ),
        ),
        separatorWidget,
        SliderExample(
          title: 'Negative Slide',
          code: exampleCode5,
          generator: (value, setValue) => CounterSlider(
            value: value,
            setValue: setValue,
            width: 240,
            height: 64,
            slideFactor: 0.8,
          ),
        ),
        separatorWidget,
        separatorWidget,
        separatorWidget,
        const MaterialInputs(),
        separatorWidget,
        const DebugColors(),
      ],
    );
  }
}

class SliderExample extends StatefulWidget {
  const SliderExample({
    super.key,
    required this.generator,
    required this.code,
    required this.title,
  });

  final CounterSlider Function(int value, void Function(int)) generator;
  final String code, title;

  @override
  State<SliderExample> createState() => _SliderExampleState();
}

class _SliderExampleState extends State<SliderExample> {
  int value = 0;

  void setValue(int value) {
    setState(() {
      this.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.title,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            separatorWidget,
            FilledButton(
              onPressed: () => Clipboard.setData(
                ClipboardData(text: widget.code),
              ),
              child: const Text('Copy code'),
            ),
          ],
        ),
        separatorWidget,
        Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: widget.generator(value, setValue),
                  ),
                ),
                separatorWidget,
                SelectableText(
                  widget.code,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
      ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other material widgets for reference',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        separatorWidget,
        Row(
          children: [
            Switch(value: switchState, onChanged: setSwitch),
            separatorWidget,
            Checkbox(value: checkbox, onChanged: setCheckbox),
            separatorWidget,
            FilledButton(onPressed: () {}, child: const Text('Button')),
            separatorWidget,
            OutlinedButton(onPressed: () {}, child: const Text('Button')),
            separatorWidget,
            ElevatedButton(onPressed: () {}, child: const Text('Button'))
          ],
        ),
      ],
    );
  }
}

class DebugColors extends StatelessWidget {
  const DebugColors({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Theme values',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        separatorWidget,
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
