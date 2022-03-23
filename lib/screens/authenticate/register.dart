import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/validators.dart'
    show emailValidator, passwordValidator;

class Register extends StatefulWidget {
  final Function toggleView;

  Register({required this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Register'),
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Sign In'),
                  style: ButtonStyle(
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 50,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 20),
                    Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red[900],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      validator: emailValidator,
                      onChanged: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                        icon: Icon(Icons.email),
                        hintText: 'E-Mail',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      obscureText: true,
                      validator: passwordValidator,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                    ),
                    SizedBox(height: 20),
                    TextButton.icon(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result =
                              await _auth.register(email, password);
                          print(result);

                          if (result == null) {
                            setState(() {
                              error =
                                  "The email address is already in use by another account.";
                              loading = false;
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.person_add),
                      label: Text('Create a Account'),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
