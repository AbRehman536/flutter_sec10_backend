import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sec10_backend/models/user.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier{
  UserModel _userModel = UserModel();

  //set user
  void setUser(UserModel value){
    _userModel = value;
    notifyListeners();
  }

  //get user
  UserModel getUser() => _userModel;
}