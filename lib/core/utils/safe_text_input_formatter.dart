import 'package:flutter/services.dart';
import 'package:todo/core/utils/text_sanitizer.dart';

/// A [TextInputFormatter] that removes unsafe invisible characters.
///
/// Use this in [TextField.inputFormatters] to prevent crashes when pasting
/// or typing malicious/broken Unicode sequences causing Skia issues on Android 15+.
class SafeTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String cleanText = TextSanitizer.sanitize(newValue.text);

    if (cleanText == newValue.text) {
      return newValue;
    }

    // If text was modified (chars removed), we need to adjust the selection
    // to avoid index out of bounds or cursor jumping weirdly.
    final int changeLength = newValue.text.length - cleanText.length;
    final int newSelectionIndex = newValue.selection.baseOffset - changeLength;

    return newValue.copyWith(
      text: cleanText,
      selection: TextSelection.collapsed(
        offset: newSelectionIndex.clamp(0, cleanText.length),
      ),
    );
  }
}
