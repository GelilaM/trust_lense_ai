/// Ethiopian-style mobile: exactly 10 digits, prefix `09` or `07` (e.g. 0911......).
abstract final class PhoneValidation {
  static String normalizeDigits(String input) =>
      input.replaceAll(RegExp(r'\D'), '');

  /// Returns `null` if valid, otherwise an error message.
  static String? validate(String? raw) {
    if (raw == null || raw.trim().isEmpty) {
      return 'Phone number is required';
    }
    final digits = normalizeDigits(raw);
    if (digits.length != 10) {
      return 'Enter exactly 10 digits (e.g. 0911......)';
    }
    if (!digits.startsWith('09') && !digits.startsWith('07')) {
      return 'Number must start with 09 or 07';
    }
    return null;
  }

  static bool isValid(String raw) => validate(raw) == null;
}
