import 'dart:io';

import 'package:flutter_travel_ui/models/auth_model.dart';
import 'package:flutter_travel_ui/networking/api_provider.dart';
import 'dart:async';

class AuthRepository {
  ApiProvider _provider = ApiProvider();

  Future<Auth> signIn(String email, String password) async {
    Map<String, dynamic> authData = {"email": email, "password": password};
    final response = await _provider.post("api/signin", authData);
    return Auth.fromJson(response);
  }

  // Future<bool> isSignedIn() async {
  //   final currentUser = await _firebaseAuth.currentUser();
  //   return currentUser != null;
  // }
  Future<Auth> verifyToken(String token) async {
    Map<String, String> headers = {
      'authorization': token,
      'Content-Type': 'application/json'
    };
    print(headers);
    final response =
        await _provider.getWithHeader("api/me", headersData: headers);
    return Auth.fromJson(response);
  }

  Future<Auth> signUp(String email, String password, phone) async {
    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "phone": int.parse(phone)
    };
    final response = await _provider.post("api/signup", authData);
    return Auth.fromJson(response);
  }

  Future<Auth> signOut() async {
    final response = await _provider.get('api/signout');
    return Auth.fromJson(response);
  }
}
