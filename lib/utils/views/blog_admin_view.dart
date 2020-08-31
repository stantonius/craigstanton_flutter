import 'package:CraigStantonWeb/utils/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/views/blog_form.dart';
import '../../utils/views/signin_view.dart';

class BlogAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(child: Consumer<User>(builder: (_, user, __) {
      if (user == null) {
        return SignInView();
      } else {
        return MainForm();
      }
    }));
  }
}
