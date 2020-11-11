import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/sign_in_view_model.dart';
import '../widgets/anonymous_sign_in_button.dart';
import '../widgets/google_sign_in_button.dart';
import '../models/const_utils.dart';

class SignInView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final isLoading = useProvider(isLoadingStateNotifier).isLoading;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              'Sign In',
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
          Expanded(
              child: isLoading ? _loadingIndicator() : _signInButtons(context)),
          //child: _signInButtons(context)),
        ],
      ),
    );
  }

  Center _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Column _signInButtons(BuildContext context) {
    return Column(
      children: <Widget>[
        const Spacer(),
        ConstUtils().helperUtils.isMicrosoftHosted()
            ? const AnonymousSignInButton()
            : Container(),
        GoogleSignInButton(),
        const Spacer(),
      ],
    );
  }
}
