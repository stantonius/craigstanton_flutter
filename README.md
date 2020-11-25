# Craig Stanton's Flutter Site

## Things Learned

- **Context**: tells the current widget everything about its parent, and their parent, all the way up the _vertical_ tree. It will also tell the widget details about the current screen size, etc. One other thing to note - the word `context` in the Flutter code can be changed to anything - it's just tradition to call it context but sometimes it helps to rename the context for ease of understanding
- **Build**: often seen as `build(BuildContext)` in the code. It simply creates new context for the current widget(s). Therefore, there exists a `Builder()` widget that allows you to create a new context as needed

## Development notes

File upload:

- Was hoping to be able to use the [file picker extension](https://pub.dev/packages/form_builder_file_picker) of the [Flutter form builder](https://pub.dev/packages/flutter_form_builder) package. However there were issues currently with web and file access (some issue with [path provider](https://github.com/flutter/flutter/issues/45296)). So I needed to use the file picker library [especially for web](https://pub.dev/packages/file_picker_cross), and then append the uploaded markdown file as string to the Global Key map object

Deploying to Firebase:

- Use this command `firebase deploy --only hosting:craigstanton-3b97f`

Running Flutter web in VSCode online
`flutter run --release -d web-server --web-hostname=0.0.0.0 --web-port=3000`

Secret Manager

- I attempted to use GCP Secret Manager for storing some API keys. Unfortunately, we gave run into the same issues as before, where CORS is preveting us from calling the API in Flutter web. Therefore I am using [a library](https://pub.dev/packages/envify) that leverages `.env` files - this is not ideal, but it is te best option I can find. It seems this is one of the limitations of Flutter Web currently - neither APIs for key management (due to CORS) nor `Dotenv` package work in FW.

### Weather app

- Tried to use the Google Places API, but ran into CORS restrictions when using Flutter Web (it works for Android, iOS). So ended up using here.com
