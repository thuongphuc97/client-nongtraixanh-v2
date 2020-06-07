import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/Animation/FadeAnimation.dart';
import 'package:flutter_travel_ui/UI/screens/main_screen.dart';
import 'package:flutter_travel_ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_travel_ui/blocs/login/login_bloc.dart';
import 'package:flutter_travel_ui/models/auth_model.dart';
import 'package:flutter_travel_ui/repository/auth_repository.dart';

import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  final AuthRepository _authRepository = new AuthRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<LoginBloc>(
        create: (context) => LoginBloc(),
        child: LoginForm(authRepository: _authRepository),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Chưa có tài khoản? ',
              style: TextStyle(fontSize: 16),
            ),
            GestureDetector(
              child: Text(
                'Đăng ký ngay!',
                style: TextStyle(color: Color(0xff3277D8), fontSize: 16),
              ),
              onTap: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  final AuthRepository _authRepository;

  LoginForm({Key key, @required AuthRepository authRepository})
      : assert(authRepository != null),
        _authRepository = authRepository,
        super(key: key);

  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  AuthRepository get _authRepository => widget._authRepository;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    var isHidePass = true;
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) async {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đăng nhập thất bại, vui lòng kiểm tra lại'),
                    Icon(Icons.error)
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                behavior: SnackBarBehavior.floating,
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Đang đăng nhập...'),
                    CupertinoActivityIndicator(
                      radius: 20,
                    ),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          // AuthRepository authenticateRepository = AuthRepository();
          Auth auth = await widget._authRepository
              .signIn(_emailController.text, _passwordController.text);
          BlocProvider.of<AuthBloc>(context).add(AuthLoggedIn(auth));
          String token = auth.token;
          String uid = auth.uid;
          if (auth.auth) {
            final _storage = FlutterSecureStorage();
            await _storage.write(key: "token", value: token);
            await _storage.write(key: "uid", value: uid);
            Scaffold.of(context)..removeCurrentSnackBar();
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => MainScreen()));
          }
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Form(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                            child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage("assets/images/1.png"),
                              ),
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end, //can duoi
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          // Greet
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 60),
                          child: Text("Chào mừng\nBạn quay trở lại!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 40)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
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
                            keyboardType: TextInputType.emailAddress,
                            autovalidate: true,
                            autocorrect: false,
                            validator: (_) {
                              return !state.isEmailValid
                                  ? 'Invalid Email'
                                  : null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextFormField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                                labelText: "Mật Khẩu",
                                prefixIcon: Icon(Feather.lock, size: 20),
                                suffixIcon: InkWell(
                                    child: isHidePass
                                        ? Icon(Feather.eye, color: Colors.grey)
                                        : Icon(
                                            Feather.eye,
                                          ),
                                    onTap: () => setState(() {
                                          isHidePass = !isHidePass;
                                        })),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(6)))),
                            obscureText: isHidePass,
                            autovalidate: true,
                            autocorrect: false,
                            validator: (_) {
                              return !state.isPasswordValid
                                  ? 'Invalid Password'
                                  : null;
                            },
                          ),
                        ),
                        Container(
                          // constraints: BoxConstraints.loose(Size(double.infinity, 10)),
                          alignment: AlignmentDirectional.centerEnd,
                          child: Padding(
                            padding: const EdgeInsets.all(5),
                            child: GestureDetector(
                              onTap: null,
                              child: Text(
                                "Quên mật khẩu?",
                                style: TextStyle(
                                    fontSize: 16, color: Color(0xff606470)),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(
                                width: double.infinity,
                                height: 52,
                                child: RaisedButton(
                                  child: Text(
                                    "Đăng Nhập",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                  color: Colors.green,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  onPressed: isLoginButtonEnabled(state)
                                      ? _onFormSubmitted
                                      : null,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    FocusScope.of(context).unfocus();
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
