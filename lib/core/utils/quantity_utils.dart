class QuantityUtils {
  QuantityUtils._();

  static int parseToMilli(
    String input,
  ) {
    var value =
        input.trim().replaceAll(',', '.');

    if (value.isEmpty) {
      throw const FormatException(
        'أدخل الكمية.',
      );
    }

    final parts = value.split('.');

    if (parts.length > 2) {
      throw const FormatException(
        'صيغة الكمية غير صحيحة.',
      );
    }

    final wholeText =
        parts[0].isEmpty ? '0' : parts[0];

    if (!RegExp(r'^\d+$').hasMatch(wholeText)) {
      throw const FormatException(
        'صيغة الكمية غير صحيحة.',
      );
    }

    var fraction =
        parts.length == 2 ? parts[1] : '';

    if (fraction.isNotEmpty &&
        !RegExp(r'^\d+$').hasMatch(fraction)) {
      throw const FormatException(
        'صيغة الكمية غير صحيحة.',
      );
    }

    if (fraction.length > 3) {
      throw const FormatException(
        'الكمية تسمح بثلاث منازل عشرية فقط.',
      );
    }

    fraction = fraction.padRight(3, '0');

    return int.parse(wholeText) * 1000 +
        (fraction.isEmpty
            ? 0
            : int.parse(fraction));
  }

  static String formatMilli(
    int quantityMilli,
  ) {
    final whole = quantityMilli ~/ 1000;
    final fraction = quantityMilli % 1000;

    if (fraction == 0) {
      return whole.toString();
    }

    var fractionText =
        fraction.toString().padLeft(3, '0');

    fractionText =
        fractionText.replaceFirst(
      RegExp(r'0+$'),
      '',
    );

    return '$whole.$fractionText';
  }
}
