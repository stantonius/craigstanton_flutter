import 'package:CraigStantonWeb/utils/services/authentication/firebase_auth_service.dart';
import 'package:CraigStantonWeb/utils/services/riverpod/riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'utils/theme/theme.dart';
import 'utils/routes/route_generator.dart';
import 'package:flutter/material.dart';

/// TODO
/// Move initial state to separate folder once working
final appAuthProvider = ChangeNotifierProvider((ref) => FirebaseAuthService());

void main() async {
  /// Below might be needed for apps. Firebase,initialiseApp() currently in index.html
  ///await Firebase.initializeApp();
  /// Also placeholder for Google crashlytics
  runApp(ProviderScope(
    observers: [
      Logger(),
    ],
    child: MyApp(),
  ));
}

/*
  MultiProvider(providers: [
      Provider(create: (_) => FirebaseAuthService()),
      StreamProvider(
          create: (context) =>
              context.read<FirebaseAuthService>().onAuthStateChanged)
    ], child: MyApp()));
*/
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      debugShowCheckedModeBanner: true,
      initialRoute: '/',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
