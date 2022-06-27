import 'package:flutter/material.dart';
import 'package:instakilo/methods/auth_methods.dart';
import 'package:instakilo/models/user.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUserdata => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserdata();
    _user = user;
    notifyListeners();
  }
}
