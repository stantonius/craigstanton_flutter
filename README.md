# Craig Stanton's Flutter Site

## Things Learned

- **Context**: tells the current widget everything about its parent, and their parent, all the way up the _vertical_ tree. It will also tell the widget details about the current screen size, etc. One other thing to note - the word `context` in the Flutter code can be changed to anything - it's just tradition to call it context but sometimes it helps to rename the context for ease of understanding
- **Build**: often seen as `build(BuildContext)` in the code. It simply creates new context for the current widget(s). Therefore, there exists a `Builder()` widget that allows you to create a new context as needed

## Development notes

### File upload:

- Was hoping to be able to use the [file picker extension](https://pub.dev/packages/form_builder_file_picker) of the [Flutter form builder](https://pub.dev/packages/flutter_form_builder) package. However there were issues currently with web and file access (some issue with [path provider](https://github.com/flutter/flutter/issues/45296)). So I needed to use the file picker library [especially for web](https://pub.dev/packages/file_picker_cross), and then append the uploaded markdown file as string to the Global Key map object

### Deploying to Firebase:

- Use this command `firebase deploy --only hosting:craigstanton-3b97f`

### Running Flutter web in VSCode online

Was using VSCode online (aka Codespaces) for a while, but gave up as the the environment was unstable
`flutter run --release -d web-server --web-hostname=0.0.0.0 --web-port=3000`

### Weather app

- Tried to use the Google Places API for Place Autocomplete and Place Details, but ran into CORS restrictions when using Flutter Web (it works for Android, iOS). So had to use a Cloud Function middleware (code is [here](https://github.com/stantonius/craigstanton_api_nodejs)). I also used a free weather API from Climacell. It allows for 1000 calls a day for free. The API key is stored in `.env` - see below for rationale.

### Secret Manager

- I attempted to use GCP Secret Manager for storing some API keys. Unfortunately, we gave run into the same issues as before, where CORS is preveting us from calling the API in Flutter web. Therefore I am using [a library](https://pub.dev/packages/envify) that leverages `.env` files - this is not ideal, but it is te best option I can find. It seems this is one of the limitations of Flutter Web currently - neither APIs for key management (due to CORS) nor `Dotenv` package work in FW.

### Firebase Auth

TODO: add more info about the config here

- Do not forget to **whitelist domains** for access to Google's OAuth2.0 service. You do this by logging into GCP console > APIs & Services > Credentials. Then select the OAuth 2.0 Client IDs (in this case its _CraigStanton_flutter_) and here you will see the authorised URIs.
