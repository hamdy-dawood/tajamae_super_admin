import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstance {
  static const String appFontName = 'Cairo';

  // date & time & currency format
  static DateFormat dateFormat = DateFormat('dd-MM-yyyy', 'en');
  static DateFormat timeFormat = DateFormat('hh:mm a', 'en');
  static NumberFormat currencyFormat = NumberFormat("#,##0", "en_US");
  static DateFormat arabicDateFormat = DateFormat("d MMMM y", "ar");

  static String dateFromMilliseconds(int milliseconds) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(milliseconds).toLocal();
    return "${dateFormat.format(date)}";
  }

  static DateTime parseDate(String dateString) {
    List<String> parts = dateString.split('-');
    int day = int.parse(parts[0]);
    int month = int.parse(parts[1]);
    int year = int.parse(parts[2]);

    String formattedDateString =
        '$year-${month.toString().padLeft(2, '0')}-${day.toString().padLeft(2, '0')}T00:00:00.000';

    return DateTime.tryParse(formattedDateString) ?? DateTime.now();
  }

  // numbers format
  static String formatNumbers(num number) {
    return NumberFormat('#,###.##').format(number);
  }

  // different dates
  String getDateDifferenceFormatted(DateTime startDate, DateTime endDate) {
    final duration = endDate.difference(startDate);
    final totalDays = duration.inDays.abs();

    if (totalDays < 30) {
      return '$totalDays يوم';
    } else if (totalDays < 365) {
      int months = (totalDays / 30).floor();
      return '$months شهر';
    } else {
      int years = (totalDays / 365).floor();
      return '$years سنة';
    }
  }

  //========================== LAUNCHERS ==========================//

  static Future<void> launchWhatsApp(String phone, String message) async {
    final Uri url;

    if (Platform.isIOS) {
      url = Uri.parse(
        "whatsapp://send?phone=${formatNumber(phone)}&text=${Uri.encodeComponent(message)}",
      );
    } else {
      url = Uri.parse(
        "https://api.whatsapp.com/send/?phone=${phone.replaceAll("+", "")}&text=${Uri.encodeComponent(message)}",
      );
    }

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  static String formatNumber(String phone) {
    return phone.replaceAll(" ", "");
  }

  static Future<void> launchInBrowser(String url) async {
    final Uri uri = Uri.parse(url);

    try {
      final canLaunch = await canLaunchUrl(uri);
      if (canLaunch) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Cannot launch URL: $uri';
      }
    } catch (e) {
      debugPrint('Failed to launch URL: $e');
      // You can show a snack bar or toast here instead of crashing
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      bool canLaunch = await canLaunchUrl(launchUri);
      if (canLaunch) {
        await launchUrl(launchUri);
      } else {
        debugPrint('Cannot launch phone call to $phoneNumber');
      }
    } catch (e) {
      debugPrint('Error launching phone call: $e');
    }
  }

  static Future<void> launchEmail({
    required String toEmail,
    String subject = '',
    String body = '',
  }) async {
    final Uri gmailUri = Uri.parse(
      'https://mail.google.com/mail/?view=cm&fs=1&to=$toEmail&su=$subject&body=$body',
    );

    if (await canLaunchUrl(gmailUri)) {
      await launchUrl(gmailUri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not open Gmail.';
    }
  }
}

///========================== FORMATTERS ==========================//

class ThousandsFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final nonDigit = RegExp(r'[^\d]');
    String newText = newValue.text.replaceAll(nonDigit, '');

    if (newText.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final formattedText = _formatter.format(int.parse(newText));
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}

//================

class ThousandsDecimalInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat.decimalPattern();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String newText = newValue.text.replaceAll(',', '');

    // Handle empty or standalone decimal point
    if (newText.isEmpty || newText == ".") {
      return newValue;
    }

    // Allow valid decimal numbers only
    final double? value = double.tryParse(newText);
    if (value == null) {
      return oldValue;
    }

    // Split integer and decimal parts
    final parts = newText.split('.');
    final intPart = parts[0];
    final decimalPart = parts.length > 1 ? parts[1] : null;

    // Format integer part
    final formattedInt = _formatter.format(int.tryParse(intPart) ?? 0);

    // Rebuild the final string
    final newFormatted =
        decimalPart != null ? "$formattedInt.$decimalPart" : formattedInt;

    return TextEditingValue(
      text: newFormatted,
      selection: TextSelection.collapsed(offset: newFormatted.length),
    );
  }
}

//================

String cleanFormat(String value) {
  return value.replaceAll(',', '');
}

//======================================================================
