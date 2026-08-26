class MoneyUtils {
  MoneyUtils._();

  static int parseToMinor(
    String input,
    int decimalPlaces,
  ) {
    var value = input.trim().replaceAll(',', '.');

    if (value.isEmpty) {
      throw const FormatException(
        'أدخل الرصيد.',
      );
    }

    var negative = false;

    if (value.startsWith('-')) {
      negative = true;
      value = value.substring(1);
    } else if (value.startsWith('+')) {
      value = value.substring(1);
    }

    final parts = value.split('.');

    if (parts.length > 2) {
      throw const FormatException(
        'صيغة المبلغ غير صحيحة.',
      );
    }

    final wholeText =
        parts[0].isEmpty ? '0' : parts[0];

    if (!RegExp(r'^\d+$').hasMatch(wholeText)) {
      throw const FormatException(
        'صيغة المبلغ غير صحيحة.',
      );
    }

    var fractionText =
        parts.length == 2 ? parts[1] : '';

    if (fractionText.isNotEmpty &&
        !RegExp(r'^\d+$').hasMatch(fractionText)) {
      throw const FormatException(
        'صيغة المبلغ غير صحيحة.',
      );
    }

    if (fractionText.length > decimalPlaces) {
      throw FormatException(
        'العملة تسمح بـ $decimalPlaces منازل عشرية فقط.',
      );
    }

    fractionText =
        fractionText.padRight(decimalPlaces, '0');

    final factor = _pow10(decimalPlaces);

    final whole = int.parse(wholeText);
    final fraction = fractionText.isEmpty
        ? 0
        : int.parse(fractionText);

    final result =
        (whole * factor) + fraction;

    return negative ? -result : result;
  }

  static String formatMinor(
    int amountMinor,
    int decimalPlaces,
  ) {
    final negative = amountMinor < 0;
    final absolute = amountMinor.abs();
    final factor = _pow10(decimalPlaces);

    final whole = absolute ~/ factor;
    final fraction = absolute % factor;

    if (decimalPlaces == 0) {
      return '${negative ? '-' : ''}$whole';
    }

    final fractionText = fraction
        .toString()
        .padLeft(decimalPlaces, '0');

    return '${negative ? '-' : ''}$whole.$fractionText';
  }

  static int _pow10(int power) {
    var value = 1;

    for (var i = 0; i < power; i++) {
      value *= 10;
    }

    return value;
  }
}
