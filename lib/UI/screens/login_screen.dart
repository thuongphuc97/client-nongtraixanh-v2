import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/feather.dart';
import 'package:flutter_travel_ui/UI/screens/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var url = "http://localhost:9090";
  var isHidePass = true;
  var _isLoading = true;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 80, 8, 8),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('Login'),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    decoration: InputDecoration(
                        prefixIcon: Icon(
                          Feather.getIconData('mail'),
                          size: 20,
                        ),
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: passController,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                    obscureText: isHidePass,
                    decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        prefixIcon: Icon(Feather.getIconData('lock'), size: 20),
                        suffixIcon: InkWell(
                          child: isHidePass
                              ? Icon(Feather.getIconData('eye'),
                                  color: Colors.grey)
                              : Icon(Feather.getIconData('eye'),
                                  color: Colors.green),
                          onTap: () {
                            setState(() {
                              isHidePass = !isHidePass;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Color(0xffCED0D2), width: 1),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
                Container(
                  // constraints: BoxConstraints.loose(Size(double.infinity, 10)),
                  alignment: AlignmentDirectional.centerEnd,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: GestureDetector(
                      onTap: null,
                      child: Text(
                        "Quên mật khẩu?",
                        style:
                            TextStyle(fontSize: 16, color: Color(0xff606470)),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: () {
                        signIn(emailController.text, passController.text);
                      },
                      child: Text(
                        "Đăng Nhập",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: RichText(
                    text: TextSpan(
                        text: "Người mới?",
                        style:
                            TextStyle(color: Color(0xff606470), fontSize: 16),
                        children: <TextSpan>[
                          TextSpan(
                              text: " Đăng ký tài khoản",
                              style: TextStyle(
                                  color: Color(0xff3277D8), fontSize: 16))
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  signIn(String email, pass) async {
    var e = "phuc@gmail.com";
    var p = "phuc123A@";
    SharedPreferences preferences = await SharedPreferences.getInstance();
    Map data = {"email": e, 'password': p};
    print('data: $data');

    var res = await http.post(url + "/api/signin",
        headers: {'Content-Type': 'application/json'}, body: jsonEncode(data));
    var jsonRes = json.decode(res.body);
    print(res.body);
    if (jsonRes != null) {
      setState(() {
        _isLoading = false;
      });
      preferences.setString("token", jsonRes['token']);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
          (Route<dynamic> route) => false);
    } else {
      setState(() {
        _isLoading = false;
      });
      print(res.body);
    }
  }
}
