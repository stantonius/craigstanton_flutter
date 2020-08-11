# Craig Stanton's Flutter Site

## Things Learned

* **Context**: tells the current widget everything about its parent, and their parent, all the way up the *vertical* tree. It will also tell the widget details about the current screen size, etc. One other thing to note - the word `context` in the Flutter code can be changed to anything - it's just tradition to call it context but sometimes it helps to rename the context for ease of understanding
* **Build**: often seen as `build(BuildContext)` in the code. It simply creates new context for the current widget(s). Therefore, there exists a `Builder()` widget that allows you to create a new context as needed

## Development notes

File upload:
* Was hoping to be able to use the [file picker extension](https://pub.dev/packages/form_builder_file_picker) of the [Flutter form builder](https://pub.dev/packages/flutter_form_builder) package. However there were issues currently with web and file access (some issue with [path provider](https://github.com/flutter/flutter/issues/45296)). So I needed to use the file picker library [especially for web](https://pub.dev/packages/file_picker_cross), and then append the uploaded markdown file as string to the Global Key map object


Deploying to Firebase:
* Use this command `firebase deploy --only hosting:craigstanton-3b97f`