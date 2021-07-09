// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:logger/logger.dart';

// Project imports:
import '../locator.dart';

// Returns screen size
Size getScreenSize({@required BuildContext context}) {
  return MediaQuery.of(context).size;
}

// Returns Keyboard size
double getKeyboardSize({@required BuildContext context}) {
  return MediaQuery.of(context).viewInsets.bottom;
}

// Closes keyboard by clicking any where on screen
void closeKeyboard({
  @required BuildContext context,
  @required VoidCallback onClose,
}) {
  if (getKeyboardSize(context: context) > 0.0) {
    FocusScope.of(context).requestFocus(FocusNode());
    try {
      onClose();
    } catch (e) {
      locator.get<Logger>().e(e);
    }
  }
}

T enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value.split(".").last,
      orElse: () => null);
}

