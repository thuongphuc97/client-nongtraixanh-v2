import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool notificationOn = false;
  bool darkMode = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    CircleAvatar(
                      child: Icon(Icons.ac_unit),
                      radius: 45,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Dinh Hoang Nhung',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text('012344'),
                          OutlineButton(
                            highlightedBorderColor: Colors.blue,
                            onPressed: () {},
                            child: Text('Edit'),
                          )
                        ],
                      ),
                    ),
                  ],
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
                      ListTile(
                        leading: Icon(Feather.lock),
                        title: Text("Change Password"),
                      ),
                    ]),
                  )),
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
                              setState(() {
                                darkMode = newValue;
                                
                              });
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
