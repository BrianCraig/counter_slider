import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class IDDarkMode {}

class IDPrimary {}

class IDSecondary {}

class IDDemoValue {}

class IDWidth {}

class IDHeight {}

class IDSliding {}

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
        create: (_) => ChangeNotifierValue<double, IDSliding>(1.4),
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
        const SettingOptions(),
        const SizedBox(
          height: 32,
        ),
        Text(
          'Demo',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.start,
        ),
        separatorWidget,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const DemoShow(),
            SizedBox(
              height: 160,
              child: SelectableText(
                generateCode(context),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 64,
        ),
        const MaterialInputs(),
      ],
    );
  }
}

class SettingOptions extends StatelessWidget {
  const SettingOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Settings',
          textAlign: TextAlign.start,
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
          menuMaxHeight: 300,
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
          menuMaxHeight: 300,
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
                  onChanged: context.watch<CNV<bool, IDWidth>>().value
                      ? context.watch<CNV<double, IDWidth>>().onChanged
                      : null,
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
                  onChanged: context.watch<CNV<bool, IDHeight>>().value
                      ? context.watch<CNV<double, IDHeight>>().onChanged
                      : null,
                  min: 32,
                  max: 120,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: const SizedBox(
            width: 58,
          ),
          title: Row(
            children: [
              Text(
                'Slide factor',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Expanded(
                child: Slider(
                  value: context.watch<CNV<double, IDSliding>>().value,
                  onChanged: context.watch<CNV<double, IDSliding>>().onChanged,
                  min: 0.5,
                  max: 3,
                ),
              ),
            ],
          ),
        ),
        ListTile(
          leading: CounterSlider(
            value: context.watch<CNV<int, IDBorder>>().value,
            onChanged: context.watch<CNV<int, IDBorder>>().onChanged,
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
            onChanged: context.watch<CNV<int, IDSpacing>>().onChanged,
            width: 96,
            height: 32,
            minValue: 0,
            maxValue: 8,
          ),
          title: const Text(
            'Gap size',
          ),
        ),
      ],
    );
  }
}

class DemoShow extends StatelessWidget {
  const DemoShow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          onChanged: context.watch<CNV<int, IDDemoValue>>().onChanged,
          width: context.watch<CNV<bool, IDWidth>>().value
              ? context.watch<CNV<double, IDWidth>>().value
              : null,
          height: context.watch<CNV<bool, IDHeight>>().value
              ? context.watch<CNV<double, IDHeight>>().value
              : null,
          slideFactor: context.watch<CNV<double, IDSliding>>().value,
          borderSize: context.watch<CNV<int, IDBorder>>().value.toDouble(),
          gapSize: context.watch<CNV<int, IDSpacing>>().value.toDouble(),
        ),
      ),
    );
  }
}

String generateCode(BuildContext context) => [
      "CounterSlider(\n  value:value,\n  onChanged: onChanged,\n",
      if (context.watch<CNV<bool, IDWidth>>().value)
        "  width: ${context.watch<CNV<double, IDWidth>>().value.round()},\n",
      if (context.watch<CNV<bool, IDHeight>>().value)
        "  height: ${context.watch<CNV<double, IDHeight>>().value.round()},\n",
      "  slideFactor: ${context.watch<CNV<double, IDSliding>>().value.toStringAsFixed(2)},\n",
      "  borderSize: ${context.watch<CNV<int, IDBorder>>().value},\n",
      "  gapSize: ${context.watch<CNV<int, IDSpacing>>().value},\n",
      "}",
    ].join();

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

const separatorWidget = SizedBox(
  height: 8.0,
  width: 8.0,
);
