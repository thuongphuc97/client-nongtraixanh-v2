class User {
  String sId;
  int phone;
  String email;
  String username;
  String password;
  String lastname;
  String firstname;
  String avatar;
  String address;

  User(
      {this.sId,
      this.phone,
      this.email,
      this.username,
      this.password,
      this.lastname,
      this.firstname,
      this.avatar,
      this.address});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    phone = json['phone'];
    email = json['email'];
    username = json['username'];
    password = json['password'];
    lastname = json['lastname'];
    firstname = json['firstname'];
    avatar = json['avatar'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['username'] = this.username;
    data['password'] = this.password;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    data['avatar'] = this.avatar;
    data['address'] = this.address;
    return data;
  }
}
