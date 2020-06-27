import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:flutter_travel_ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_travel_ui/blocs/validate.dart';
import 'package:flutter_travel_ui/models/auth_model.dart';
import 'package:flutter_travel_ui/repository/auth_repository.dart';
import 'package:flutter_travel_ui/widgets/dialog.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  Validate validate = new Validate();
  var isHidePass = true;

  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passController = new TextEditingController();
  final TextEditingController phoneController = new TextEditingController();
  final TextEditingController rePassController = new TextEditingController();
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
                  child: StreamBuilder(
                      stream: validate.emailStream,
                      builder: (context, snapshot) {
                        return TextField(
                          //Username
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                              errorText:
                                  snapshot.hasError ? snapshot.error : null,
                              prefixIcon: Icon(
                                Feather.mail,
                                size: 20,
                              ),
                              labelText: "Email",
                              border: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.red, width: 4),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6)))),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.number,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        labelText: "Số Điện Thoại",
                        prefixIcon: Icon(Feather.phone, size: 20),
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
                    style: TextStyle(fontSize: 18),
                    obscureText: isHidePass,
                    decoration: InputDecoration(
                        labelText: "Mật Khẩu",
                        prefixIcon: Icon(Feather.lock, size: 20),
                        suffixIcon: InkWell(
                          child: isHidePass
                              ? Icon(Feather.eye, color: Colors.grey)
                              : Icon(
                                  Feather.eye,
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
                    controller: rePassController,
                    style: TextStyle(fontSize: 18),
                    obscureText: isHidePass,
                    decoration: InputDecoration(
                        labelText: "Nhập Lại Mật Khẩu",
                        prefixIcon: Icon(Feather.lock, size: 20),
                        suffixIcon: InkWell(
                          child: isHidePass
                              ? Icon(Feather.eye, color: Colors.grey)
                              : Icon(
                                  Feather.eye,
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
                        _onRegClick();
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

  _onRegClick() async {
    FocusScope.of(context).unfocus();
    var isValid = validate.isValid(emailController.text, phoneController.text,
        passController.text, rePassController.text);
    if (isValid) {
      LoadingDialog.showLoadingDialog(context, 'Loading...');
      AuthRepository authRepository = new AuthRepository();

      try {
        await authRepository.signUp(
            emailController.text, passController.text, phoneController.text);
        LoadingDialog.hideLoadingDialog(context);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
        MsgDialog.showMsgDialog(
            context, "Đăng kí thành công", "Vui lòng đăng nhập để sử dụng");
      } catch (e) {
        LoadingDialog.hideLoadingDialog(context);
        MsgDialog.showMsgDialog(context, "Lỗi đăng kí", "Vui lòng thử lại");
      }

      // BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn(auth));
      // String token = auth.token;
      // String uid = auth.uid;
      // final _storage = FlutterSecureStorage();
      // await _storage.write(key: "token", value: token);
      // await _storage.write(key: "uid", value: uid);
      // Scaffold.of(context)..removeCurrentSnackBar();

      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => MainScreen()));

    }
  }
}
