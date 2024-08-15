import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:movie_flutter/common/date_formatter.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

const timeZone = 'America/Mexico_City';

Future<void> prepareDateFormat() async {
  await initializeDateFormatting();
}

void main() async {
  await prepareDateFormat();
  tz.initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(timeZone));

  DateFormatter subject() {
    return const DateFormatter();
  }

  group('_DateTimeWithTimeZone', () {
    group('.utc', () {
      test('builds a utc date', () {
        final date = _DateTimeFacade.utc();
        expect(date.isUtc, isTrue);
      });

      test('builds a local date', () {
        final date = _DateTimeFacade.utc().toLocal();
        expect(date.isUtc, isFalse);
      });
    });

    test('offset its -6', () {
      final dateTime = _DateTimeFacade.utc().toLocal();
      expect(dateTime.timeZoneOffset, const Duration(hours: -6));
    });

    test('timezone is CST', () {
      final dateTime = _DateTimeFacade.utc().toLocal();
      expect(dateTime.timeZoneName, 'CST');
    });
  });

  group('.formatDate', () {
    final months = {
      1: 'Ene',
      2: 'Feb',
      3: 'Mar',
      4: 'Abr',
      5: 'May',
      6: 'Jun',
      7: 'Jul',
      8: 'Ago',
      9: 'Sep',
      10: 'Oct',
      11: 'Nov',
      12: 'Dic',
    };

    months.forEach((monthNumber, value) {
      test('returns the month $monthNumber in spanish ($value)', () {
        final dateTime = _DateTimeFacade.utc(
          year: 2024,
          month: monthNumber,
          day: 13,
        );
        final result = subject().formatDate(dateTime);
        expect(result, '$value 13, 2024');
      });
    });
  });
}

/// Fake the DateTime to use the Mexico timezone
// We use this class only on this test
// ignore: prefer-match-file-name
class _DateTimeFacade extends DateTime {
  _DateTimeFacade._(
      super.year,
      super.month,
      super.day,
      super.hour,
      super.minute,
      super.second,
      this.utcDateTime,
      );

  factory _DateTimeFacade.utc({
    int year = 2024,
    int month = 2,
    int day = 3,
    int hour = 12,
    int minute = 5,
    int second = 0,
  }) {
    final dateTime = DateTime.utc(year, month, day, hour, minute, second);

    return _DateTimeFacade._(
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
      dateTime,
    );
  }

  final DateTime utcDateTime;

  @override
  bool get isUtc => true;

  /// Allow us to fake the machine timezone to use Mexico
  @override
  DateTime toLocal() {
    return tz.TZDateTime.from(utcDateTime, tz.getLocation(timeZone));
  }
}
