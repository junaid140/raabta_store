import 'package:shared_preferences/shared_preferences.dart';

class GetToken{
  Future<String?> getToken() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getString('token');
  }
}