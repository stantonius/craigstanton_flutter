import 'package:CraigStantonWeb/utils/layouts/ResponsiveLayout.dart';
import 'package:CraigStantonWeb/utils/models/const_utils.dart';
import 'package:CraigStantonWeb/utils/models/sign_in_view_model.dart';
import 'package:CraigStantonWeb/utils/widgets/anonymous_sign_in_button.dart';
import 'package:CraigStantonWeb/utils/widgets/google_sign_in_button.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../main.dart';
import '../utils/templates/main_screen_template.dart';

class BlogAdminScreen extends StatelessWidget {
  const BlogAdminScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MainPageTemplate(BlogAdmin());
  }
}

class BlogAdmin extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final user = useProvider(appAuthStateChangesProvider);
    return user.when(
      data: (user) => _formIfUser(context, user),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const Scaffold(
        body: const Scaffold(
            body: Center(
                child: Text(
                    'Something went wrong. Cannot load the data right now'))),
      ),
    );
  }

  Widget _formIfUser(BuildContext context, user) {
    if (user != null) {
      return MainForm();
    }
    return SignInView();
  }
}

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

class MainForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            child:
                Text('New Post', style: Theme.of(context).textTheme.headline1),
          ),
          MaterialButton(
            child: Text("Sign Out"),
            onPressed: () {
              print('Context:');
              //context.signOut();
              context.read(appAuthProvider).signOut();
              //print(context.read<User>());
            },
            color: Colors.red,
          )
        ]),
        BlogUpdateForm()
      ],
    );
  }
}

class BlogUpdateForm extends StatefulWidget {
  @override
  BlogUpdateFormState createState() {
    return BlogUpdateFormState();
  }
}

class BlogUpdateFormState extends State<BlogUpdateForm> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  String _fileString;
  int _fileLength = 0;

  void _selectFile() {
    FilePickerCross.pick().then((filePicker) => setState(() {
          _fileLength = filePicker.toUint8List().lengthInBytes;
          try {
            _fileString = filePicker.toString();
            _formKey.currentState.setAttributeValue('blogfile', _fileString);
          } catch (e) {
            _fileString =
                'Not a text file. Showing base64.\n\n' + filePicker.toBase64();
          }
        }));
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(children: [
          Padding(
            padding: ResponsiveLayout.isSmallScreen(context)
                ? const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
            child: FormBuilderTextField(
              attribute: "title",
              decoration: InputDecoration(
                  filled: true, fillColor: Colors.white, labelText: 'Title'),
              validators: [FormBuilderValidators.required()],
              onEditingComplete: () => {_formKey.currentState.save()},
            ),
          ),
          Padding(
            padding: ResponsiveLayout.isSmallScreen(context)
                ? const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 100),
            child: FormBuilderTextField(
              attribute: "description",
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Description'),
              validators: [FormBuilderValidators.required()],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: FormBuilderFilterChip(
              alignment: WrapAlignment.center,
              attribute: "tag",
              options: [
                FormBuilderFieldOption(child: Text("AI"), value: "AI"),
                FormBuilderFieldOption(
                    child: Text("Microcomputing"), value: "Microcomputing"),
                FormBuilderFieldOption(
                    child: Text("Blockchain"), value: "Blockchain"),
                FormBuilderFieldOption(
                    child: Text("Random Thoughts"), value: "Random Thoughts"),
              ],
            ),
          ),
          Padding(
            padding: ResponsiveLayout.isSmallScreen(context)
                ? const EdgeInsets.symmetric(vertical: 8, horizontal: 8)
                : const EdgeInsets.symmetric(vertical: 8, horizontal: 200),
            child: Container(
              color: Colors.white,
              child: FormBuilderDateTimePicker(
                attribute: "date",
                inputType: InputType.both,
                format: DateFormat("yyyy-MM-dd H:m:ss"),
                initialDate: new DateTime.now(),
                initialTime: new TimeOfDay.now(),
                decoration: InputDecoration(
                    labelText: "Blog Date", fillColor: Colors.white),
              ),
            ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  onPressed: () => {_selectFile()},
                  child: Text('Select File'),
                ),
                MaterialButton(
                    color: Colors.red,
                    child: Text("Submit"),
                    onPressed: () {
                      if (_formKey.currentState.saveAndValidate()) {
                        //_formKey.currentState.setAttributeValue("heello", "sup");
                        FirebaseFirestore.instance
                            .collection('blog_dev')
                            .doc()
                            .set({
                          'blogfile': _formKey.currentState.value['blogfile'],
                          'title': _formKey.currentState.value['title'],
                          'description':
                              _formKey.currentState.value['description'],
                          'tag': _formKey.currentState.value['tag'],
                          'date': _formKey.currentState.value['date']
                        });
                        print('Successfully submitted');
                        _formKey.currentState.reset();
                      }
                    })
              ])
        ]));
  }
}
