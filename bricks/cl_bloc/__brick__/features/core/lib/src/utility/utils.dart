import 'dart:io';

import 'package:core/core_exports.dart';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:external_path/external_path.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';

class Utils {
  Utils._();

  static Future<DateTime?> datePicker({
    required BuildContext context,
    DateTime? currentDate,
    DateTime? initialDate,
  }) {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(DateTime.now().year + 50),
      barrierDismissible: false,
      currentDate: currentDate,
    );
  }

  static String dateStringFormat({required DateTime date}) {
    return DateFormat('yyyy/MM/dd').format(date);
  }

  static String timesheetDateFormat({required DateTime date}) {
    return DateFormat('MMMM - yyyy').format(date);
  }

  static String getMonth({required DateTime date}) {
    return DateFormat('MM').format(date);
  }

  static String getYear({required DateTime date}) {
    return DateFormat('yyyy').format(date);
  }

  static DateTime stringDateFormat({required String date}) {
    return DateFormat('yyyy/MM/dd').parse(date);
  }

  static String fullDate({required DateTime date}) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  static String currentTimeAsString() {
    return DateFormat('kk:mm a').format(DateTime.now());
  }

  static String parseDateTimeIntoString({
    required String dateTimeFormat,
    required DateTime dateTime,
  }) {
    return DateFormat(dateTimeFormat).format(dateTime);
  }

  static DateTime stringTimeToDateFormat({required String time}) {
    return DateFormat('hh:mm a').parse(time);
  }

  static Future<TimeOfDay?> timePicker({required BuildContext context}) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      barrierDismissible: false,
    );
  }

  static TimeOfDay convertStringToTimeOfDay(String timeString) {
    List<String> timeParts = timeString.split(':');
    int hours = int.parse(timeParts[0]);

    // Extract minutes and AM/PM from the second part of the split
    List<String> minuteAndMeridiem = timeParts[1].split(' ');
    int minutes = int.parse(minuteAndMeridiem[0]);
    String meridiem = minuteAndMeridiem[1];

    // Adjust hours if PM
    if (meridiem == 'PM' && hours < 12) {
      hours += 12;
    }
    // Create a TimeOfDay object
    return TimeOfDay(hour: hours, minute: minutes);
  }

  static double calculateHours(TimeOfDay time) {
    return time.hour + time.minute / 60;
  }

  static bool isSecondDateBigger(String firstDate, String secondDate) {
    // if 0 then both are same,
    // 0 < second date is before first ,
    // 0 > first date is bigger then second date
    return stringTimeToDateFormat(time: firstDate)
            .compareTo(stringTimeToDateFormat(time: secondDate)) >
        0;
  }

  static Future<XFile?> imagePicker({bool isFromGallery = true}) async {
    final picker = ImagePicker();
    return await picker.pickImage(
      source: isFromGallery ? ImageSource.gallery : ImageSource.camera,
    );
  }

  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31,
    ];
    return daysInMonth[month - 1];
  }

  static void hideKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static Future<String> getDownloadsDirectoryPath() async {
    var downloadsPath = await ExternalPath.getExternalStoragePublicDirectory(
      ExternalPath.DIRECTORY_DOWNLOAD,
    );
    return downloadsPath;
  }

  /// Opens file from Downloads folder
  static Future<void> openFile(String fileName) async {
    var downloadsPath = await getDownloadsDirectoryPath();
    final filePath = '$downloadsPath/$fileName';
    final file = File(filePath);
    if (file.existsSync()) {
      try {
        await OpenFile.open(filePath);
      } catch (e) {
        AppLogger.w('Error opening file: $e');
      }
    } else {
      AppLogger.w('File not found: $filePath');
    }
  }

  static Future<AndroidDeviceInfo> getAndroidInfo() async {
    return DeviceInfoPlugin().androidInfo;
  }

  static Future<PermissionStatus> askPermission() async {
    if (Platform.isAndroid) {
      final value = await getAndroidInfo();
      if (value.version.sdkInt > 29) {
        return Permission.manageExternalStorage.request();
      } else {
        return Permission.storage.request();
      }
    } else {
      return Permission.photos.request();
    }
  }
}
