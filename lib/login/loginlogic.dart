import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:session_storage/session_storage.dart';

String getUserRole(String token) {
  Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  if (decodedToken.containsKey('roles') && decodedToken['roles'] is List) {
    List<dynamic> roles = decodedToken['roles'];
    if (roles.isNotEmpty) {
      print(roles[0]['authority']);
      return roles[0]['authority'] ?? ''; // Return authority or empty string if not found
    }
  }
  return ''; // Return empty if roles are not available
}

  String getClientEmail(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['sub'];
  }

  String getClientName(String token) {
    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    return decodedToken['firstName'];
  }

  final session = SessionStorage();

  void storeToken(String token) {
    session['token'] = token;
  }

  String? getToken() {
    return session['token'];
  }