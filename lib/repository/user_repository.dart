import 'package:flutter_travel_ui/models/user_model.dart';

import '../networking/api_provider.dart';
import 'dart:async';

class UserRepository {
  ApiProvider _provider = ApiProvider();
  
  Future<User> signIn(String email, String password) async {
    Map<String, dynamic> authData = {"email": email, "password": password};
    final response = await _provider.post("api/signin", authData);
    return User.fromJson(response);
  }
}
