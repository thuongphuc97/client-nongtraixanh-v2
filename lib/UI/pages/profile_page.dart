import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/UI/screens/edit_profile_screen.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:flutter_travel_ui/UI/screens/password_change_sccreen.dart';
import 'package:flutter_travel_ui/blocs/auth/auth_bloc.dart';
import 'package:flutter_travel_ui/models/auth_model.dart';
import 'package:flutter_travel_ui/models/user_model.dart';
import 'package:flutter_travel_ui/repository/user_repository.dart';
import 'package:flutter_travel_ui/widgets/button.dart';
import 'package:flutter_travel_ui/widgets/profile_skeleton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationOn = false;
  bool darkMode = false;
  User _currentUser;

  UserRepository _userRepository = new UserRepository();

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  _loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = (prefs.getBool('darkMode') ?? false);
    });
  }

  _incrementCounter(newValue) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      darkMode = newValue;
      prefs.setBool('darkMode', darkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
      if (state is AuthFailure) return _unSignInScreen();
      if (state is AuthSuccess) {
        final _storage = FlutterSecureStorage();
        _storage.read(key: "uid").then((value) => setState(() {
              _userRepository
                  .getUserProfile(value)
                  .then((value) => _currentUser = value);
            }));

        return _currentUser == null ? _loadingScreen() : _signedScreen();
      }

      return _loadingScreen();
    });
  }

  _loadingScreen() {
    return Center(
        child: CupertinoActivityIndicator(
      radius: 50,
    ));
  }

  _signedScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        actions: _currentUser != null
            ? <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(curentUser: _currentUser)),
                      );
                    },
                    icon: Icon(Icons.edit))
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: NetworkImage(_currentUser.avatar),
                        radius: 45,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              _currentUser.email,
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            Text(_currentUser.lastname +
                                ' ' +
                                _currentUser.firstname),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Icon(MaterialCommunityIcons.ticket_account),
                        title: Text("My Ticket"),
                      ),
                    ]),
                  )),
              SizedBox(
                height: 12.0,
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Icon(Feather.map_pin),
                        title: Text("Location"),
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.grey,
                        indent: 10.0,
                      ),
                      ListTile(
                        leading: Icon(Feather.credit_card),
                        title: Text("Payment"),
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.grey,
                        indent: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      PasswordChangeScreen()));
                        },
                        child: ListTile(
                          leading: Icon(Feather.lock),
                          title: Text("Change Password"),
                        ),
                      ),
                    ]),
                  )),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 12),
                child: Text("Member Feathers",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Icon(Feather.help_circle),
                        title: Text("Help Center"),
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.grey,
                        indent: 10.0,
                      ),
                      ListTile(
                        leading: Icon(Feather.settings),
                        title: Text("Setting"),
                      ),
                    ]),
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RedGradientButton(
                      text: "Đăng xuất",
                      onTap: () {
                        context.bloc<AuthBloc>().add(AuthLoggedOut());
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _unSignInScreen() {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
        centerTitle: true,
        actions: _currentUser != null
            ? <Widget>[
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProfileScreen(curentUser: _currentUser)),
                      );
                    },
                    icon: Icon(Icons.edit))
              ]
            : null,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 20, 8, 0),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                        child: GreenGradientButton(
                          text: 'Đăng nhập / Đăng ký'.toUpperCase(),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 0, 12),
                child: Text("Notifications",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Icon(Feather.bell),
                        title: Text("Notification"),
                        trailing: CupertinoSwitch(
                            value: notificationOn,
                            onChanged: (bool newValue) {
                              setState(() {
                                notificationOn = newValue;
                              });
                            }),
                      ),
                      Divider(),
                      ListTile(
                        leading: darkMode == true
                            ? Icon(Feather.moon)
                            : Icon(Feather.sun),
                        title: Text("Dark mode"),
                        trailing: CupertinoSwitch(
                            value: darkMode,
                            onChanged: (bool newValue) {
                              _incrementCounter(newValue);
                            }),
                      ),
                    ]),
                  )),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 12),
                child: Text("Member Feathers",
                    style: TextStyle(
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                    )),
              ),
              Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(children: <Widget>[
                      ListTile(
                        leading: Icon(Feather.help_circle),
                        title: Text("Help Center"),
                      ),
                      Divider(
                        height: 8.0,
                        color: Colors.grey,
                        indent: 10.0,
                      ),
                      ListTile(
                        leading: Icon(Feather.settings),
                        title: Text("Setting"),
                      ),
                    ]),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
