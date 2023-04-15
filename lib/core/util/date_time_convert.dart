import 'package:intl/intl.dart';

class DateTimeConverter {
  // Here we convert the milliseconds to real date
  static String millisecondToRealDate({required int millisecond}) {
    var formattedDate = DateFormat('d MMM, yyyy')
        .format(DateTime.fromMillisecondsSinceEpoch(millisecond));
    return formattedDate;
  }
}
