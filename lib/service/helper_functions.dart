import 'package:intl/intl.dart';

// Date formatter for year-month-day format
final dateFormatter = DateFormat('yyyy-MM-dd');

// Helper function to format strings into a numerical string
String currencyFormat(String text) {
  String newText = '';
  int indexOfDot = text.indexOf('.');
  if (indexOfDot != -1) {
    newText = text.substring(indexOfDot, text.length);
    for (var i = 0; i < indexOfDot; i++) {
      if (i != 0 && i % 3 == 0) {
        newText = ' $newText';
      }
      newText =
          text[text.length - i - 1 - (text.length - indexOfDot)] + newText;
    }
    return newText;
  }
  for (var i = 0; i < text.length; i++) {
    if (i != 0 && i % 3 == 0) {
      newText = ' $newText';
    }
    newText = text[text.length - i - 1] + newText;
  }
  return newText;
}
