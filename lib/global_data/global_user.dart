class GlobalUser {
  _GlobalUser() {}

  String _id = '';
  String _userName = '';

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get userName => _userName;

  set userName(String value) {
    _userName = value;
  }

  static GlobalUser _globalUser = new GlobalUser();

  static GlobalUser get globalUser => _globalUser;
}
