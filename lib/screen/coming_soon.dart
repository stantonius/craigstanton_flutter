import 'package:flutter/material.dart';

// Import main template and homepage class
import '../utils/templates/main_screen_template.dart';
import '../utils/models/const_utils.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(
        ConstUtils().widgetUtils.centreTextPlaceholder("Coming Soon!"));
  }
}
