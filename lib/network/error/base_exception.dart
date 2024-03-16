class BaseException implements Exception {
  BaseException({
    required this.messageText,
    required this.errorCodeStr,
  });

  final String messageText;
  final String errorCodeStr;

  @override
  String toString() {
    return messageText;
  }
}