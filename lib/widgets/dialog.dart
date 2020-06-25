import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MsgDialog {
  static void showMsgDialog(BuildContext context, String title, String msg) {
    showDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(msg),
        actions: [
          new FlatButton(
            child: Text("OK"),
            onPressed: () {
              Navigator.of(context).pop(MsgDialog);
            },
          ),
        ],
      ),
    );
  }
}

class LoadingDialog {
  static void showLoadingDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => new CupertinoAlertDialog(
        content: Container(
          height: 100,
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              new SpinKitDoubleBounce(
                color: Colors.green,
                size: 30.0,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: new Text(
                  msg,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(LoadingDialog);
  }
}
