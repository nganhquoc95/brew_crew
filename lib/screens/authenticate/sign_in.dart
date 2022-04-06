import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/validators.dart'
    show emailValidator, passwordValidator;

class SignIn extends StatefulWidget {
  final Function toggleView;

  SignIn({required this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String password = "";
  String error = "";
  bool loading = false;

  void onPressdSignInAsAnonymous() async {
    dynamic result = await _auth.signInAnonymus();
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text('Sign In'),
              elevation: 0.0,
              actions: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    widget.toggleView();
                  },
                  icon: Icon(Icons.person),
                  label: Text('Register'),
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
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                        icon: Icon(Icons.email),
                        hintText: 'E-Mail',
                      ),
                    ), // E-Mail field
                    SizedBox(height: 20),
                    TextFormField(
                      validator: passwordValidator,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      decoration: textInputDecoration.copyWith(
                        icon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                    ), // Password Field
                    SizedBox(height: 20),
                    TextButton.icon(
                      style: buttonStyle,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            loading = true;
                          });
                          dynamic result = await _auth
                              .signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              error =
                                  "The password is invalid or the user does not have a password.";
                              loading = false;
                            });
                          }
                        }
                      },
                      icon: Icon(Icons.login),
                      label: Text('Login'),
                    ), // Button Login
                  ],
                ),
              ),
            ),
          );
  }
}
