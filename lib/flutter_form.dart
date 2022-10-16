import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(child: SignUpForm()),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  bool _termsChecked = false;

  List<DropdownMenuItem<int>> genderList = [];

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          CheckboxListTile(
            value: _termsChecked,
            onChanged: (_) {
              setState(() {
                _termsChecked = !_termsChecked;
              });
            },
            subtitle: !_termsChecked
                ? const Text(
                    'Required',
                    style: TextStyle(color: Colors.red, fontSize: 12.0),
                  )
                : null,
            title: const Text(
              'I agree to the terms and condition',
            ),
            controlAffinity: ListTileControlAffinity.leading,
          ),
          const ListTile(
            leading: CircleAvatar(maxRadius: 16) ,
            title: Text(
              'I agree to the terms and condition',
            ),
            subtitle: Text(
              'I agree to the terms and condition',
            ),
          ),
          const ListTile(
            leading: CounterSlider(width: 96, height: 32, buttonBorderGap: 1, borderSize: 1) ,
            title: Text(
              'I agree to the terms and condition',
            ),
            subtitle: Text(
              'I agree to the terms and condition',
            ),
          )
        ],
      ),
    );
  }
}
