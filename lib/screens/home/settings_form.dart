import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/services/database.dart';
import 'package:brew_crew/models/user_data.dart';
import 'package:brew_crew/shared/constants.dart';

class SettingsForm extends StatefulWidget {
  @override
  _StateSettingsForm createState() => _StateSettingsForm();
}

class _StateSettingsForm extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  String? _name;
  String? _sugars;
  int? _strength;

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<User>(context);
    List<String> sugars = ['0', '1', '2', '3', '4'];

    return StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          }

          UserData userData = snapshot.data as UserData;

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
                  initialValue: userData.name,
                  validator: (value) =>
                      value == null ? 'Input your name' : null,
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
                  value: _sugars ?? userData.sugars,
                  items: sugars.map((sugar) {
                    int sugarsPercent =
                        ((double.parse(sugar) / 4) * 100).round();

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
                        value: (_strength ?? userData.strength).toDouble(),
                        min: 100.0,
                        max: 900.0,
                        activeColor:
                            Colors.brown[_strength ?? userData.strength],
                        inactiveColor:
                            Colors.brown[_strength ?? userData.strength],
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
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await DatabaseService(uid: user.uid).updateUserData(
                          _name ?? userData.name,
                          _sugars ?? userData.sugars,
                          _strength ?? userData.strength);
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.person_add),
                  label: Text('Update'),
                ), // Update button
              ],
            ),
          );
        });
  }
}
