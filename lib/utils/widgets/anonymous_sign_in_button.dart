import 'package:CraigStantonWeb/utils/models/sign_in_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnonymousSignInButton extends StatelessWidget {
  const AnonymousSignInButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: RaisedButton(
            onPressed: () {
              context.read<SignInViewModel>().signInAnonymously();
            },
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.red[900],
            child: Text("Sign In Anonymously",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ))));
  }
}
