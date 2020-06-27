import 'dart:async';

class Validate {
  StreamController _nameController = new StreamController();
  StreamController _emailController = new StreamController();
  StreamController _passController = new StreamController();
  StreamController _phoneController = new StreamController();

  Stream get nameStream => _nameController.stream;
  Stream get emailStream => _emailController.stream;
  Stream get passStream => _passController.stream;
  Stream get phoneStream => _phoneController.stream;

  bool isValid(String email, String pass, String repass, String phone) {
 
    if (phone == null || phone.length == 0) {
      _phoneController.sink.addError("Nhập số điện thoại");
      return false;
    }
    _phoneController.sink.add("");

    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    
    _passController.sink.add("");

    return true;
  }

  bool isValidLogin(String email, String pass) {
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");

    if (pass == null || pass.length < 6) {
      _passController.sink.addError("Mật khẩu phải trên 5 ký tự");
      return false;
    }
    _passController.sink.add("");

    return true;
  }

  bool isValidEmail(String email) {
    if (email == null || email.length == 0) {
      _emailController.sink.addError("Nhập email");
      return false;
    }
    _emailController.sink.add("");
    return true;
  }

  void dispose() {
    _nameController.close();
    _emailController.close();
    _passController.close();
    _phoneController.close();
  }
}
