import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end, //can duoi
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 40, 15, 8),
                  child: BackButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 110, 0, 60),
                  child: Column(
                    children: <Widget>[
                      Text('Đăng kí mới',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 40)),
                      Text('Để sử dụng đầy đủ chức năng!',
                          style: TextStyle(fontSize: 15))
                    ],
                  ),
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
                        labelText: "Email",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.red, width: 4),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6)))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                        labelText: "Số Điện Thoại",
                        prefixIcon:
                            Icon(Feather.getIconData('phone'), size: 20),
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1),
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
                        prefixIcon: Icon(Feather.getIconData('lock'), size: 20),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    obscureText: isHidePass,
                    decoration: InputDecoration(
                        labelText: "Nhập Lại Mật Khẩu",
                        prefixIcon: Icon(Feather.getIconData('lock'), size: 20),
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
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: RaisedButton(
                      onPressed: () {
                        //    signIn(emailController.text, passController.text);
                      },
                      child: const Text(
                        "Đăng Ký",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
