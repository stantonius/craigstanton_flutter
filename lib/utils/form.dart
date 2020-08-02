import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:file_picker_cross/file_picker_cross.dart';

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
    return Column(children: [
      FormBuilder(
          key: _formKey,
          autovalidate: true,
          child: Column(children: [
            FormBuilderTextField(
              attribute: "title",
              decoration: InputDecoration(
                  filled: true, fillColor: Colors.white, labelText: 'Title'),
              validators: [FormBuilderValidators.required()],
              onEditingComplete: () => {_formKey.currentState.save()},
            ),
            FormBuilderTextField(
              attribute: "description",
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  labelText: 'Description'),
              validators: [FormBuilderValidators.required()],
            ),
            FormBuilderFilterChip(
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
            Row(
              children: [
                MaterialButton(
                  color: Colors.green,
                  onPressed: () => {_selectFile()},
                  child: Text('Select File'),
                )
              ],
            ),
            Row(
              children: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  child: Text("Submit"),
                  onPressed: () {
                    if (_formKey.currentState.saveAndValidate()) {
                      _formKey.currentState.setAttributeValue("heello", "sup");
                      print(_formKey.currentState.value);
                    }
                  },
                ),
              ],
            )
          ]))
    ]);
  }
}

/*    
    Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter title';
              }
              return null;
            },
            decoration: InputDecoration(filled: true, fillColor: Colors.white),
          ),
          RaisedButton(
            onPressed: () {
              if (_formKey.currentState.validate()) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('Processing data'),
                ));
              }
            },
            child: Text('Submit'),
          )
        ],
      ),
    );
*/
