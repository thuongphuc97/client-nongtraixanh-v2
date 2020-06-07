import 'package:flutter_travel_ui/models/user_model.dart';

class Auth {
  bool auth;
  String token;
  String uid;

  Auth.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    token = json['token'];
    uid = json['uid'];
  }
  Auth() {
    auth = false;
    token = null;
    uid = null;
  }
  signOut() {
    auth = false;
    token = null;
    uid = null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['token'] = this.token;
    data['uid'] = this.uid;
    return data;
  }
}
