/// @Created by akash on 10-07-2024.
/// Know more about author at https://akash.cloudemy.in
import 'package:get/utils.dart';
import 'package:intl/intl.dart';

extension TZDateTimeExtensions on String? {
  DateTime? toLocalDateTime({String? format}) {
    if (this == null) {
      return null;
    }
    try {
      // Parse the IST date string to a DateTime object
      final dateFormat = DateFormat(format ?? getDateFormat()); // dd-MM-yyyy
      final istDateTime = dateFormat.parse(this!); //'10-07-2024'
      // Convert to TZDateTime in IST time zone
      final localDateTime = istDateTime.add(
        Duration(seconds: DateTime.now().timeZoneOffset.inSeconds - 19800),
      );
      return localDateTime;
    } catch (e) {
      e.printError();
      return null;
    }
  }

  String getDateFormat() {
    if (this == null) return 'dd MMM yyyy hh:mm:ss a';
    // Check for ISO 8601 formats
    if (this!.contains('T')) {
      if (this!.contains('Z')) {
        if (this!.contains('.')) {
          if (this!.split('.')[1].length > 3) {
            return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS'Z'"; // ISO 8601 with nanoseconds and Zulu time
          }
          return "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"; // ISO 8601 with milliseconds and Zulu time
        }
        return "yyyy-MM-dd'T'HH:mm:ss'Z'"; // ISO 8601 with Zulu time
      }
      if (this!.contains('.')) {
        if (this!.split('.')[1].length > 3) {
          return "yyyy-MM-dd'T'HH:mm:ss.SSSSSSS"; // ISO 8601 with nanoseconds
        }
        return "yyyy-MM-dd'T'HH:mm:ss.SSS"; // ISO 8601 with milliseconds
      }
      return "yyyy-MM-dd'T'HH:mm:ss"; // ISO 8601 without timezone
    }

    // Check for common formats with '/'
    if (this!.contains('/')) {
      if (this!.contains(':')) {
        if (this!.contains('AM') || this!.contains('PM')) {
          if (this!.indexOf('/') == 4) {
            return 'yyyy/MM/dd hh:mm:ss a'; // e.g., 2024/07/13 01:45:30 PM
          }
          if (int.parse(this!.split('/')[0]) <= 12) {
            return 'MM/dd/yyyy  hh:mm:ss a'; // e.g., 07/13/2024 01:45:30 PM
          }
          return 'dd/MM/yyyy  hh:mm:ss a'; // e.g., 13/07/2024 01:45:30 PM
        } else {
          if (this!.indexOf('/') == 4) {
            return 'yyyy/MM/dd HH:mm:ss'; // e.g., 2024/07/13 13:45:30
          }

          if (int.parse(this!.split('/')[0]) <= 12) {
            return 'MM/dd/yyyy HH:mm:ss'; // e.g.,07/13/2024 13:45:30
          }
          return 'dd/MM/yyyy HH:mm:ss'; // e.g., 13/07/2024 13:45:30
        }
      } else {
        if (this!.indexOf('/') == 4) {
          return 'yyyy/MM/dd'; // e.g., 2024/07/13
        }
        if (int.parse(this!.split('/')[0]) <= 12) {
          return 'MM/dd/yyyy'; // e.g., 07/13/2024
        }
        return 'dd/MM/yyyy'; // e.g., 13/07/2024
      }
    }

    // Check for common formats with '-'
    if (this!.contains('-')) {
      if (this!.contains(':')) {
        if (this!.contains('AM') || this!.contains('PM')) {
          if (this!.indexOf('-') == 4) {
            return 'yyyy-MM-dd hh:mm:ss a'; // e.g., 2024-07-13 01:45:30 PM
          }
          if (int.parse(this!.split('-')[0]) <= 12) {
            return 'MM-dd-yyyy  hh:mm:ss a'; // e.g., 07-13-2024 01:45:30 PM
          }
          return 'dd-MM-yyyy  hh:mm:ss a'; // e.g., 13-07-2024 01:45:30 PM
        } else {
          if (this!.indexOf('-') == 4) {
            return 'yyyy-MM-dd HH:mm:ss'; // e.g., 2024-07-13 13:45:30
          }

          if (int.parse(this!.split('-')[0]) <= 12) {
            return 'MM-dd-yyyy HH:mm:ss'; // e.g.,07-13-2024 13:45:30
          }
          return 'dd-MM-yyyy HH:mm:ss'; // e.g., 13-07-2024 13:45:30
        }
      } else {
        if (this!.indexOf('-') == 4) {
          return 'yyyy-MM-dd'; // e.g., 2024-07-13
        }
        if (int.parse(this!.split('-')[0]) <= 12) {
          return 'MM-dd-yyyy'; // e.g., 07-13-2024
        }
        return 'dd-MM-yyyy'; // e.g., 13-07-2024
      }
    }

    // Check for formats with space

    final value = this!.trim();
    final parts = value.split(' ');
    if(parts.any((element) => element.trim().isEmpty,)) {
      return "";
    }
    // ---------- dd MMM yyyy ----------
    if (parts.length >= 3 && parts[1].length == 3) {
      if (value.contains(':')) {
        if (value.split(':').length == 3) {
          if (value.contains('AM') || value.contains('PM')) {
            return 'dd MMM yyyy hh:mm:ss a';
          }
          return 'dd MMM yyyy HH:mm:ss';
        }
        if (value.contains('AM') || value.contains('PM')) {
          return 'dd MMM yyyy hh:mm a';
        }
        return 'dd MMM yyyy HH:mm';
      }
      return 'dd MMM yyyy';
    }

    // ---------- MMM dd yyyy ----------
    if (parts.length >= 3 && parts[0].length == 3) {
      if (value.contains(':')) {
        if (value.split(':').length == 3) {
          if (value.contains('AM') || value.contains('PM')) {
            return 'MMM dd yyyy hh:mm:ss a';
          }
          return 'MMM dd yyyy HH:mm:ss';
        }
        if (value.contains('AM') || value.contains('PM')) {
          if (!value.split(':').last.contains(' ')) {
            return 'MMM dd yyyy hh:mma';
          }
          return 'MMM dd yyyy hh:mm a';
        }
        return 'MMM dd yyyy HH:mm';
      }
      return 'MMM dd yyyy';
    }

    // ---------- MMM yyyy ----------
    if (parts.length == 2 && parts[0].length == 3) {
      return 'MMM yyyy';
    }
    return "";
    throw FormatException('Unknown date format: $this');
  }

  DateTime? toDateTime({String? format}) {
    if (this == null || this!.isEmpty) {
      return null;
    }
    // Parse the IST date string to a DateTime object
    final dateFormatString = format ?? getDateFormat();
    if(dateFormatString.isEmpty){
      return null;
    }
    final dateFormat = DateFormat(dateFormatString);
    final istDateTime = dateFormat.parse(this!);

    return istDateTime;
  }
  bool isExpired({String? format}) {
    if (this == null || this!.isEmpty) {
      return true;
    }
    // Parse the IST date string to a DateTime object
    final dateFormat = DateFormat(format ?? getDateFormat());
    final istDateTime = dateFormat.parse(this!);

    return istDateTime.isBefore(DateTime.now());
  }
}

extension DateTimeExtensions on DateTime? {
  String get toDateStr => toStr(format: 'dd MMM yyyy');

  String toStr({String? format}) {
    if (this == null) {
      return '  --  ';
    }
    final dateFormat = DateFormat(format ?? 'dd MMM yyyy hh:mm a');
    final dateTime = dateFormat.format(this!);
    return dateTime;
  }
}
