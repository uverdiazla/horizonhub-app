import 'package:horizon_hub/core/contracts/i_date_formatter.dart';
import 'package:intl/intl.dart';

/// Implementation of IDateFormatter to handle date formatting
class DateFormatter implements IDateFormatter {
  @override
  String formatDate(DateTime date) {
    // Default format: yyyy-MM-dd
    return DateFormat('yyyy-MM-dd').format(date);
  }

  @override
  String formatDateWithMonthName(DateTime date) {
    // Format with full month name: August 07, 2024
    return DateFormat('MMMM dd, yyyy').format(date);
  }
}
