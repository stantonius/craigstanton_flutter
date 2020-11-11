import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart' as buttons;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../main.dart';

class GoogleSignInButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return buttons.GoogleSignInButton(
      onPressed: () {
        context.read(appAuthProvider).signInWithGoogle();
      },
      darkMode: true,
    );
  }
}
