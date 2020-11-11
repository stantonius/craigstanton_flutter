import 'package:flutter/material.dart';
import 'package:hooks_riverpod/all.dart';
import '../../main.dart';
import '../../utils/views/blog_form.dart';
import '../../utils/views/signin_view.dart';

class BlogAdmin extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final user = watch(appAuthProvider);
    print('This is user ${user.currentUser}');
    if (user == null) {
      return SignInView();
    }
    return MainForm();
  }
}
