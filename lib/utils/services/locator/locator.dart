import 'package:CraigStantonWeb/utils/services/locator/navigation.dart';
import 'package:get_it/get_it.dart';

/// I'm not actually sure if I needed to do this. It seems a bit overkill to
/// use a global key but I followed this tutorial that used this approach
/// https://www.filledstacks.com/post/template-layouts-and-navigation-in-flutter-web/
/// The code is here
/// https://github.com/FilledStacks/flutter-tutorials/tree/master/037-advanced-web-navigation/00-starting/lib

GetIt locator = GetIt.instance;

void setupLocator() {
  /// SIngleton means there will only ever be one navigation system in existance
  locator.registerLazySingleton(() => NavigationService());
}
