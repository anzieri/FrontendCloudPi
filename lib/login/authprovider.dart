import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String? _token;
  String? _role;
  String? _name;

  String? get token => _token;
  String? get role => _role;
  String? get name => _name;

  Future<void> login(String token, String role, String name) async {
    _token = token;
    _role = role;
    _name = name;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
    await prefs.setString('user_role', role);
    await prefs.setString('first_name', name);
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    _role = null;
    _name = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
    await prefs.remove('user_role');
    await prefs.remove('first_name');
    notifyListeners();
  }

  Future<void> loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    _role = prefs.getString('user_role');
    _name = prefs.getString('first_name');
    notifyListeners();
  }

  bool get isAuthenticated => _token != null;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }
}