import 'package:flutter/material.dart';

class GreenGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const GreenGradientButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: 200,
        height: 42,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Color.fromRGBO(26, 255, 26, 0.3),
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 6.0))
            ],
            borderRadius: BorderRadius.circular(6.0),
            gradient: LinearGradient(colors: [
              Color.fromRGBO(102, 255, 26, 1),
              Color.fromRGBO(68, 204, 0, 1),
            ])),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: onTap,
    );
  }
}

class RedGradientButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const RedGradientButton({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width - 50,
        height: 42,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 0.0,
                  offset: Offset(0.0, 6.0))
            ],
            borderRadius: BorderRadius.circular(6.0),
            gradient: onTap != null
                ? LinearGradient(colors: [
                    Color.fromRGBO(255, 0, 0, 1),
                    Color.fromRGBO(204, 0, 0, 1),
                  ])
                : LinearGradient(colors: [
                    Colors.black,
                    Colors.grey,
                  ])),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
              color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.bold),
        ),
      ),
      onTap: onTap,
    );
  }
}

class ProfileListButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Icon icon;
  final String rightText;
  final bool isDisable;
  const ProfileListButton(
      {this.text, this.onTap, this.icon, this.rightText, this.isDisable});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
          height: 55,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  //                    <--- top side
                  color: Colors.black,
                  width: 0.1,
                ),
                bottom: BorderSide(
                  //                    <--- top side
                  color: Colors.black,
                  width: 0.1,
                ),
              )),
          alignment: Alignment(-1, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: icon,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: rightText == null
                    ? null
                    : Text(rightText,
                        style: isDisable != null
                            ? TextStyle(color: Colors.grey)
                            : TextStyle()),
              ),
            ],
          )),
    );
  }
}
