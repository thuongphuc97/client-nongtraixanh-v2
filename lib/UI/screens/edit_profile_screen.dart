import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_travel_ui/models/user_model.dart';
import 'package:flutter_travel_ui/repository/user_repository.dart';
import 'package:flutter_travel_ui/widgets/button.dart';

class EditProfileScreen extends StatefulWidget {
  final User curentUser;

  const EditProfileScreen({Key key, this.curentUser}) : super(key: key);
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController lastNameController = new TextEditingController();
    lastNameController.text = widget.curentUser.lastname;
    TextEditingController firstNameController = new TextEditingController();
    firstNameController.text = widget.curentUser.firstname;
    return Scaffold(
      appBar: AppBar(
        title: Text('Chỉnh sửa thông tin'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Email (Không thay đổi được):'),
            TextFormField(
              decoration: InputDecoration(
                  prefixText: 'Email',
                  labelText: widget.curentUser.email,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
              enabled: false,
            ),
            Text('Họ:'),
            TextFormField(
              controller: lastNameController,
              decoration: InputDecoration(
                  hintText: lastNameController.text,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
            ),
            Text('Tên:'),
            TextFormField(
              controller: firstNameController,
              decoration: InputDecoration(
                  hintText: firstNameController.text,
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 4),
                      borderRadius: BorderRadius.all(Radius.circular(6)))),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: GreenGradientButton(
                  text: 'lưu thông tin'.toUpperCase(),
                  onTap: () async {
                    await saveProfile(
                        firstNameController.text, lastNameController.text);
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  saveProfile(firstName, lastName) async {
    UserRepository _userRepository = new UserRepository();
    String uid="";
    final _storage = FlutterSecureStorage();
    uid= await _storage.read(key: "uid");
        print(uid);
        await _userRepository.updateProfile(uid, firstName, lastName);
  }
}
