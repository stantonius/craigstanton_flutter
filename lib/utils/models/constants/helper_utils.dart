import 'package:platform_info/platform_info.dart';

class HelperUtils {
  isMicrosoftHosted<bool>() {
    // Checking machine for testing purposes
    final Platform _platform = Platform();
    final String version = _platform.operatingSystem.toString();
    if (version == 'OperatingSystem.windows') {
      return true;
    } else if (version == 'OperatingSystem.android') {
      return true;
    } else if (version == 'OperatingSystem.unknown') {
      return true;
    }
    {
      return false;
    }
  }
}
