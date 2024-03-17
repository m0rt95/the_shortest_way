// ignore_for_file: avoid_classes_with_only_static_members

class TextValidator{
  static bool isUrl(String input) {
    final RegExp regex = RegExp(
      r'^(?:http|https):\/\/'
      r'(?:(?:[A-Z0-9][A-Z0-9-]{0,61}[A-Z0-9]\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|'
      'localhost|'
      r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})'
      r'(?::\d+)?'
      r'(?:\/?[^\s]*)?$',
      caseSensitive: false,
    );
    return regex.hasMatch(input);
  }

}