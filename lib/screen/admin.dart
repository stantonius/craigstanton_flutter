import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';
import '../utils/form.dart';

class Admin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: LitAuthState(
                authenticated: MainForm(),
                unauthenticated: Center(
                    child: LitAuth(
                        config: AuthConfig(
                  title: Text('Sign In',
                      style: Theme.of(context).textTheme.headline1),
                )))

                //unauthenticated: BlogUpdateForm(),
                //unintialized: BlogUpdateForm(),
                )));
  }
}
