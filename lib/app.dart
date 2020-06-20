import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'UI/screens/main_screen.dart';
import 'blocs/auth/auth_bloc.dart';
import 'models/auth_model.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = true;
  _loadDarkMode() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDark = (prefs.getBool('darkMode') ?? false);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadDarkMode();
  }

  @override
  Widget build(BuildContext context) {
    Auth auth = new Auth();

    return BlocProvider(
      create: (context) => AuthBloc(auth)..add(AuthStarted()),
      child: MaterialApp(
          title: 'HUTECH TRAVEL',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFF3EBACE),
            accentColor: Color(0xFFD8ECF1),
            scaffoldBackgroundColor: Color(0xFFF3F5F7),
            accentIconTheme: IconThemeData(color: Colors.blue),
            iconTheme: IconThemeData(color: Colors.blue),
          ),
          darkTheme: _isDark ? ThemeData.dark() : null,
          home: MainScreen()
          // home: LoginScreen(),
          ),
    );
  }
}
