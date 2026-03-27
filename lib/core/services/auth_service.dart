import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService extends GetxService {
  late SharedPreferences _prefs;
  final _userId = RxnString();
  final _isLoggedIn = false.obs;

  String? get userId => _userId.value;
  bool get isLoggedIn => _isLoggedIn.value;

  Future<AuthService> init() async {
    _prefs = await SharedPreferences.getInstance();
    _userId.value = _prefs.getString('user_id');
    _isLoggedIn.value = _userId.value != null;
    return this;
  }

  Future<void> saveUser(String id) async {
    await _prefs.setString('user_id', id);
    _userId.value = id;
    _isLoggedIn.value = true;
  }

  Future<void> logout() async {
    await _prefs.remove('user_id');
    _userId.value = null;
    _isLoggedIn.value = false;
  }
}
