import 'package:apptest/model/user.model.dart';

class UserState {

  static UserState _instance;
  static UserState get intance{
    if (_instance == null) {
      _instance = new UserState();
    }
    return _instance;
  }

  UserModel currentUser;
  bool isInitial = true;
}