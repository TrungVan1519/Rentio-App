import 'dart:core';

abstract class Validation {
  void isValid(bool isValid);
}

class RegexModel {
  bool isAllNormalCharaters(String checkedString) {
    RegExp regExp = new RegExp('[a-zA-Z0-9]');
    Iterable<RegExpMatch> matches = regExp.allMatches(checkedString);

    if (matches.length == checkedString.length &&
        matches.elementAt(0).start == 0 &&
        matches.elementAt(matches.length - 1).end == checkedString.length) {
      return true;
    }
    return false;
  }

  bool isAllNumber(String checkedString) {
    RegExp regExp = new RegExp('[0-9]');
    Iterable<RegExpMatch> matches = regExp.allMatches(checkedString);

    if (matches.length == checkedString.length &&
        matches.elementAt(0).start == 0 &&
        matches.elementAt(matches.length - 1).end == checkedString.length) {
      return true;
    }
    return false;
  }

  bool isValidEmail(String checkedEmail) {
    String suffixes = 'gmail.com';
    List<String> parts = checkedEmail.split('@');

    if (parts.length == 2) {
      if (parts[1].compareTo(suffixes) == 0) {
        RegExp regExp = new RegExp('[a-zA-Z0-9]');
        Iterable<RegExpMatch> matches = regExp.allMatches(parts[0]);

        if (matches.length == parts[0].length &&
            matches.elementAt(0).start == 0 &&
            matches.elementAt(matches.length - 1).end == parts[0].length) {
          return true;
        }
      }
    }
    return false;
  }
}
