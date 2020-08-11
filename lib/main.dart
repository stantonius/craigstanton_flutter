import './utils/theme.dart';
import './routes.dart';
import 'package:flutter/material.dart';
import 'package:lit_firebase_auth/lit_firebase_auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LitAuthInit(
        authProviders: AuthProviders(
            emailAndPassword: false, google: true, anonymous: true),
        child: MaterialApp(
          theme: appTheme(),
          debugShowCheckedModeBanner: true,
          initialRoute: '/',
          routes: routes,
        ));
  }
}
