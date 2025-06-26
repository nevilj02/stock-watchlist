import 'package:intl/intl.dart';

class IntlHelper {
  static String formatDate(DateTime date) =>
      DateFormat.yMMMd().format(date);

  static String formatCurrency(num value) =>
      NumberFormat.simpleCurrency().format(value);
} 