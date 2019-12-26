class StringManipulator {
  static String changeFirstLetterUpperCase(String word) {
    String newWord = word.substring(0, 1).toUpperCase() + word.substring(1);
    return newWord;
  }
}
