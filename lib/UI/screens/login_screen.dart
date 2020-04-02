import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/feather.dart';
import 'package:flutter_travel_ui/UI/screens/main_screen.dart';
import 'package:flutter_travel_ui/UI/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // var url = "http://localhost:9090";
  var url = "https://tourserver.herokuapp.com";
  var isHidePass = true;
  var _isLoading = true;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 200, 8, 8),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end, //can duoi
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    // Greet
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 60),
                    child: Text("Chào mừng\nBạn quay trở lại!",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      //Username
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Feather.getIconData('mail'),
                            size: 20,
                          ),
                          labelText: "Username",
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 4),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6)))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: passController,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                      obscureText: isHidePass,
                      decoration: InputDecoration(
                          labelText: "Mật Khẩu",
                          prefixIcon:
                              Icon(Feather.getIconData('lock'), size: 20),
                          suffixIcon: InkWell(
                            child: isHidePass
                                ? Icon(Feather.getIconData('eye'),
                                    color: Colors.grey)
                                : Icon(
                                    Feather.getIconData('eye'),
                                  ),
                            onTap: () {
                              setState(() {
                                isHidePass = !isHidePass;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.white, width: 1),
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
                    padding: const EdgeInsets.fromLTRB(20, 40, 0, 20),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Nguoi moi? ',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          child: Text(
                            'Dang ki ngay!',
                            style: TextStyle(
                                color: Color(0xff3277D8), fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()));
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
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
