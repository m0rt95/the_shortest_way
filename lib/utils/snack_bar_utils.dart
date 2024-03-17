import 'dart:ui';

import 'package:bot_toast/bot_toast.dart';

void showSnackBar(String message) {
  const Color contentColor = Color(0xFFD0BCFF);

  BotToast.showText(
    contentColor: contentColor,
    text: message,
    duration: const Duration(seconds: 4),
  );
}