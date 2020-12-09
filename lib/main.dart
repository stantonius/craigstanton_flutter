import 'package:CraigStantonWeb/utils/routes/router.dart';
import 'package:CraigStantonWeb/utils/routes/route_names.dart';
import 'package:CraigStantonWeb/utils/services/authentication/firebase_auth_service.dart';
import 'package:CraigStantonWeb/utils/services/locator/locator.dart';
import 'package:CraigStantonWeb/utils/services/locator/navigation.dart';
import 'package:CraigStantonWeb/utils/services/riverpod/logger.dart';
import 'package:CraigStantonWeb/utils/templates/main_layout.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'utils/theme/theme.dart';
import 'package:flutter/material.dart';

/// TODO
/// Move initial state to separate folder once working
final appAuthProvider = ChangeNotifierProvider((ref) => FirebaseAuthService());
final appAuthStateChangesProvider =
    StreamProvider((ref) => ref.watch(appAuthProvider).onAuthStateChanged);
final appThemeProvider = StateProvider((ref) => false);

void main() async {
  /// Firebase,initialiseApp() currently in index.html also for web app
  await Firebase.initializeApp();

  /// Locator for navigator and standard template
  setupLocator();

  /// Placeholder for Google crashlytics
  runApp(ProviderScope(
    observers: [
      Logger(),
    ],
    child: MyApp(),
  ));
}

class MyApp extends HookWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = useProvider(appThemeProvider).state;
    return MaterialApp(
      theme: appTheme(isDarkTheme),
      builder: (context, child) => MainLayoutTemplate(
          child: child), // the child is the view returned from the router
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: HomeRoute,
    );
  }
}
