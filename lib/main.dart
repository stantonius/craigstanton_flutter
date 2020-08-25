import 'package:CraigStantonWeb/utils/services/authentication/firebase_auth_service.dart';

import './utils/theme.dart';
//import './routes.dart';
import './utils/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiProvider(providers: [
      Provider(create: (_) => FirebaseAuthService()),
      StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged)
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      //routes: routes,
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
