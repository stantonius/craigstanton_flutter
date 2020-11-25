import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify()
abstract class Env {
  static const climacell_api = _Env.climacell_api;
}
