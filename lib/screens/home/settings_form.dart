import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _StateSettingsForm createState() => _StateSettingsForm();
}

class _StateSettingsForm extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _sugars = "0";
  int _strength = 100;

  @override
  Widget build(BuildContext context) {
    List<String> sugars = ['0', '1', '2', '3', '4'];
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Update your brew settings!',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ), // Heading text
          SizedBox(height: 20),
          TextFormField(
            initialValue: _name,
            validator: (value) => value == null ? 'Input your name' : null,
            onChanged: (val) {
              setState(() {
                _name = val;
              });
            },
            decoration: textInputDecoration.copyWith(
              icon: Icon(Icons.email),
              hintText: 'Name',
            ),
          ), // Name field
          SizedBox(height: 20),
          DropdownButtonFormField(
            decoration: textInputDecoration.copyWith(
              icon: Icon(Icons.hdr_strong),
            ),
            value: _sugars,
            items: sugars.map((sugar) {
              int sugarsPercent = ((double.parse(sugar) / 4) * 100).round();

              return DropdownMenuItem(
                child: Text('$sugarsPercent% sugar(s)'),
                value: sugar,
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                _sugars = value ?? "0";
              });
            },
          ), // Sugars selection
          SizedBox(height: 20),
          Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Icon(Icons.coffee, color: Colors.grey[400]),
              Expanded(
                child: Slider(
                  value: _strength.toDouble(),
                  min: 100.0,
                  max: 900.0,
                  activeColor: Colors.brown[_strength],
                  inactiveColor: Colors.brown[_strength],
                  divisions: 8,
                  onChanged: (val) {
                    setState(() {
                      _strength = val.toInt();
                    });
                  },
                ),
              ), // Strength slider
            ],
          ),
          SizedBox(height: 20),
          TextButton.icon(
            style: buttonStyle,
            onPressed: () {},
            icon: Icon(Icons.person_add),
            label: Text('Update'),
          ), // Update button
        ],
      ),
    );
  }
}
