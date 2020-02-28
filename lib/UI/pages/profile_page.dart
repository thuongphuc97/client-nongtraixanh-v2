import 'package:flutter/material.dart';
import 'package:flutter_travel_ui/UI/screens/login_screen.dart';
import 'package:flutter_travel_ui/models/tour_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<Tour> fetchAlbum() async {
    final response = await http
        .get('http://localhost:9090/api/tours/5e53f367b4596c9802c64c7d');
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response, then parse the JSON.
      return Tour.fromJson(json.decode(response.body));
    } else {
      // If the server did not return a 200 OK response, then throw an exception.
      throw Exception('Failed to load album');
    }
  }

  Future<Tour> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                RaisedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  ),
                  child: Text('Login'),
                ),
                FutureBuilder<Tour>(
                  future: futureAlbum,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          Text(snapshot.data.title),
                          Image.network(snapshot.data.imagesUrl)
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ),
        ));
  }
}
