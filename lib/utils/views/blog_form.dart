import 'package:CraigStantonWeb/utils/services/authentication/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker_cross/file_picker_cross.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../layouts/ResponsiveLayout.dart';

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
              context.read<FirebaseAuthService>().signOut();
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
                        Firestore.instance
                            .collection('blog_dev')
                            .document()
                            .setData({
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
