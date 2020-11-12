import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Logger to observe if provider initialised

class Logger extends ProviderObserver {
  @override
  void didAddProvider(ProviderBase provider, Object value) {
    print('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "provider_name": "${provider.name}",
      "provider_from": "${provider.from}",
      "provider_argument": "${provider.argument}",
      "provider_runtimeType": "${provider.runtimeType}",
      "value": "$value",
    }
    
    ''');
  }

  void didUpdateProvider(ProviderBase provider, Object newValue) {
    print('''
    {
      "provider": "${provider.name ?? provider.runtimeType}",
      "newValue": "$newValue",
    }
    
    ''');
  }
}
