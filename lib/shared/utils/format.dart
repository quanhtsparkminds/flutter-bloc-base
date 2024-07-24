import 'package:intl/intl.dart';

enum Rounding { roundUp, normalRounding }

class Formart {
  static String formatErrFirebaseLoginToString(String err) {
    String message = '';
    switch (err) {
      case 'ERROR_ARGUMENT_ERROR':
        message = 'Vui lòng nhập đầy đủ dữ liệu';
        break;
      case 'ERROR_OPERATION_NOT_ALLOWED':
        message = 'Phương thức đăng nhập này chưa được cho phép';
        break;
      case 'user-disabled':
        message = 'Tài khoản này đã bị khoá';
        break;
      case 'invalid-email':
        message = 'Định dạng Email không đúng';
        break;
      case 'user-not-found':
        message = 'Tài khoản không tồn tại';
        break;
      case 'wrong-password':
        message = 'Sai mật khẩu, vui lòng nhập lại';
        break;
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        message = 'Email này đã được sử dụng. Vui lòng đăng nhập';
        break;
      case 'too-many-requests':
        message = 'Quá giới hạn số lần yêu cầu, xin hãy thử lại sau';
        break;
      case 'invalid-verification-code':
        message = 'Mã xác nhận không chính xác';
        break;
      case 'invalid-phone-number':
        message = 'Số điện thoại không hợp lệ';
        break;
      case 'ERROR_SESSION_EXPIRED':
        message = 'Mã xác nhận đã hết hạn, nhấn gửi lại.';
        break;
      case 'missing-client-identifier':
        message = 'Gửi yêu cầu lỗi';
        break;
      default:
        message = 'Lỗi Đăng Nhập';
    }
    return message;
  }

  static String formatCurrency(
    dynamic inputStr, {
    String currencySign = '\$',
    Rounding roundType = Rounding.normalRounding,
  }) {
    double value = 0.0;
    int lengthOf = lenghtPartDecimals(inputStr.toString());

    // Convert input to double
    if (inputStr is double || inputStr is int) {
      value = double.parse(inputStr.toString());
    } else if (inputStr is String && inputStr.isNotEmpty) {
      value = double.parse(inputStr);
    }

    // Handle rounding
    switch (roundType) {
      case Rounding.roundUp:
        value = double.parse(value.toStringAsFixed(0));
        break;
      case Rounding.normalRounding:
      default:
        value = double.parse(value.toStringAsFixed(lengthOf));
        break;
    }

    String formattedValue = value.toStringAsFixed(lengthOf);
    List<String> parts = formattedValue.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';
    integerPart =
        NumberFormat.decimalPattern('de_DE').format(int.parse(integerPart));
    formattedValue = '$integerPart${lengthOf == 0 ? '' : ','}$decimalPart';
    String result = '$currencySign$formattedValue';

    return result;
  }

  static int lenghtPartDecimals(String input) {
    if (input.contains('.')) {
      List<String> parts = input.split('.');

      if (parts.length == 2) {
        String decimalPart = parts[1];
        return decimalPart.length;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }
}

bool isMaxLength(String fields, int length) {
  return fields.length <= length;
}
