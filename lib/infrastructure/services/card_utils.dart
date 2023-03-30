// ignore_for_file: constant_identifier_names

import 'my_errors.dart';

class CardUtils {
  static String? validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return Errors.fieldReq;
    }

    int year;
    int month;

    if (value.contains(RegExp(r'(/)'))) {
      var split = value.split(RegExp(r'(/)'));
      month = int.parse(split[0]);
      year = int.parse(split[1]);
    } else {
      month = int.parse(value.substring(0, (value.length)));
      year = -1;
    }

    if ((month < 1) || (month > 12)) {
      return Errors.monthInvalid;
    }

    var fourDigitsYear = convertYearTo4Digits(year);
    if ((fourDigitsYear < 1) || (fourDigitsYear > 2099)) {
      return Errors.yearInvalid;
    }

    if (!hasDateExpired(month, year)) {
      return Errors.cardExpired;
    }
    return null;
  }

  /// Convert the two-digit year to four-digit year if necessary
  static int convertYearTo4Digits(int year) {
    if (year < 100 && year >= 0) {
      var now = DateTime.now();
      String currentYear = now.year.toString();
      String prefix = currentYear.substring(0, currentYear.length - 2);
      year = int.parse('$prefix${year.toString().padLeft(2, '0')}');
    }
    return year;
  }

  static bool hasDateExpired(int month, int year) {
    return isNotExpired(year, month);
  }

  static bool isNotExpired(int year, int month) {
    // It has not expired if both the year and date has not passed
    return !hasYearPassed(year) && !hasMonthPassed(year, month);
  }

  static List<int> getExpiryDate(String value) {
    var split = value.split(RegExp(r'(/)'));
    return [int.parse(split[0]), int.parse(split[1])];
  }

  static bool hasMonthPassed(int year, int month) {
    var now = DateTime.now();
    return hasYearPassed(year) ||
        convertYearTo4Digits(year) == now.year && (month < now.month + 1);
  }

  static bool hasYearPassed(int year) {
    int fourDigitsYear = convertYearTo4Digits(year);
    var now = DateTime.now();
    return fourDigitsYear < now.year;
  }

  static String getCleanedNumber(String text) {
    RegExp regExp = RegExp(r"\D");
    return text.replaceAll(regExp, '');
  }

  static String? validateCardNum(String? input) {
    if (input == null || input.isEmpty) {
      return Errors.fieldReq;
    }
    if (!RegExp(r"^[\d -' ']{19}$").hasMatch(input)) {
      return Errors.numberIsInvalid;
    } else {
      return null;
    }
  }


  static CardType getCardTypeFrmNumber(String input) {
    CardType cardType;
    if (input.startsWith(RegExp(r'(8600)'))) {
      cardType = CardType.Uzcard;
    } else if (input.startsWith(RegExp(r'(9860)'))) {
      cardType = CardType.Humo;
    } else if (input.startsWith(RegExp(
        r'((5[1-5])|(222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720))'))) {
      cardType = CardType.Master;
    } else if (input.startsWith(RegExp(r'[4]'))) {
      cardType = CardType.Visa;
    } else if (input.startsWith(RegExp(r'((506(0|1))|(507(8|9))|(6500))'))) {
      cardType = CardType.Verve;
    } else if (input.startsWith(RegExp(r'((34)|(37))'))) {
      cardType = CardType.AmericanExpress;
    } else if (input.startsWith(RegExp(r'((6[45])|(6011))'))) {
      cardType = CardType.Discover;
    } else if (input.startsWith(RegExp(r'((30[0-5])|(3[89])|(36)|(3095))'))) {
      cardType = CardType.DinersClub;
    } else if (input.startsWith(RegExp(r'(352[89]|35[3-8][0-9])'))) {
      cardType = CardType.Jcb;
    } else if (input.length <= 8) {
      cardType = CardType.Others;
    } else {
      cardType = CardType.Invalid;
    }
    return cardType;
  }


  static String? validateEmpty(String? input) {
    if (input == null || input.isEmpty) {
      return Errors.fieldReq;
    } else {
      return null;
    }
  }
}

 enum CardType {
  Uzcard,
  Humo,
  Master,
  Visa,
  Verve,
  Discover,
  AmericanExpress,
  DinersClub,
  Jcb,
  Others,
  Invalid
}
