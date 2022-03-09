import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void onPressdSignInAsAnonymous() async {
    AuthService _auth = AuthService();
    dynamic result = await _auth.signInAnonymus();
    print(result);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Column(
        children: [
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onPressdSignInAsAnonymous,
                child: Text('Sign In as Anonymous'),
              )
            ],
          ),
        ],
      ),
    );
  }
}
