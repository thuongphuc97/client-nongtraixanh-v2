class Auth {
  bool auth;
  String token;

  Auth({this.auth, this.token});

  Auth.fromJson(Map<String, dynamic> json) {
    auth = json['auth'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['auth'] = this.auth;
    data['token'] = this.token;
    return data;
  }
}
