import 'dart:math';

class UuidUtils {
  UuidUtils._();

  static final Random _random =
      Random.secure();

  static String v4() {
    final bytes =
        List<int>.generate(
      16,
      (_) => _random.nextInt(256),
    );

    bytes[6] =
        (bytes[6] & 0x0f) | 0x40;

    bytes[8] =
        (bytes[8] & 0x3f) | 0x80;

    String hex(
      int value,
    ) =>
        value
            .toRadixString(16)
            .padLeft(2, '0');

    final text =
        bytes.map(hex).join();

    return '${text.substring(0, 8)}-'
        '${text.substring(8, 12)}-'
        '${text.substring(12, 16)}-'
        '${text.substring(16, 20)}-'
        '${text.substring(20, 32)}';
  }
}
