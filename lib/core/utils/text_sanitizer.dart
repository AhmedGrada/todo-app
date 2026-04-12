/// Utility to sanitize text and prevent Skia engine crashes on Android 15+.
///
/// Removes zero-width characters and other invisible control characters that
/// can cause `skia::textlayout::ParagraphImpl::getUTF16Index` native crashes.
class TextSanitizer {
  // Regex to match:
  // \u200B: Zero-width space
  // \u200C: Zero-width non-joiner
  // \u200D: Zero-width joiner
  // \uFEFF: Zero-width no-break space (BOM)
  // \u2060: Word joiner (zero width)
  // \u2061: Function application
  // \u2062: Invisible times
  // \u2063: Invisible separator
  // \u2064: Invisible plus
  static final RegExp _unsafeChars = RegExp(
    // Part 1: Invisible characters (Antigravity's fix)
    r'[\u200B-\u200D\uFEFF\u2060-\u2064]|'
    // Part 2: Isolated Surrogates (The Android 15 "Magic" Fix)
    r'[\uD800-\uDBFF](?![\uDC00-\uDFFF])|(^|[^\uD800-\uDBFF])[\uDC00-\uDFFF]',
    unicode: true,
  );

  /// Sanitizes the input string by removing unsafe invisible characters.
  ///
  /// Returns the original string if [input] is null or empty.
  static String sanitize(String? input) {
    if (input == null || input.isEmpty) return input ?? '';
    return input.replaceAll(_unsafeChars, '');
  }
}

/// Extension for easy access to sanitization.
extension SafeTextExtension on String {
  /// Returns a sanitized version of this string safe for Skia rendering.
  String get sanitizeForSkia => TextSanitizer.sanitize(this);
}
