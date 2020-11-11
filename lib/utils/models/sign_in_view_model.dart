import 'package:CraigStantonWeb/utils/services/authentication/firebase_auth_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final isLoadingStateNotifier =
    StateNotifierProvider((_) => SignInViewModel(false));

class SignInViewModel extends StateNotifier {
  SignInViewModel(state) : super(state);

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> signInAnonymously() async {
    _setLoading();
    await FirebaseAuthService().signInAnonymously();
    _setNotLoading();
  }

  void _setLoading() {
    _isLoading = true;
  }

  void _setNotLoading() {
    _isLoading = false;
  }
}
