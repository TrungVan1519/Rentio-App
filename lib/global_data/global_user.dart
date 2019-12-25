class GlobalUser {
  String _id = '';
  String _userID;

  String _userName = '';

  static GlobalUser _globalUser = new GlobalUser();

  _GlobalUser() {}

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  String get userID => _userID;

  set userID(String value) {
    _userID = value;
  }

  static GlobalUser get globalUser => _globalUser;
}
