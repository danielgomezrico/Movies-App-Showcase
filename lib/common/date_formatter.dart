import 'package:intl/intl.dart';

class DateFormatter {
  const DateFormatter();

  String formatDate(DateTime dateTime) {
    final customFormat = DateFormat('MMM d, y');

    final localDateTime = dateTime.toLocal();

    final formattedDate = customFormat.format(localDateTime);

    final firstLetterCapitalized =
        formattedDate[0].toUpperCase() + formattedDate.substring(1);

    return firstLetterCapitalized;
  }
}
