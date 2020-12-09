import 'package:flutter/material.dart';
import '../utils/models/const_utils.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstUtils().widgetUtils.centreTextPlaceholder("Coming Soon!");
  }
}
