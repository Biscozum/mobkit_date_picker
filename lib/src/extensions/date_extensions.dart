extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }

  bool? isAfterOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isAfter(dateTime);
  }

  bool? isBeforeOrEqualTo(DateTime dateTime) {
    final date = this;
    final isAtSameMomentAs = dateTime.isAtSameMomentAs(date);
    return isAtSameMomentAs | date.isBefore(dateTime);
  }

  bool? isBetween(
    DateTime fromDateTime,
    DateTime toDateTime,
  ) {
    final date = this;
    final isAfter = date.isAfterOrEqualTo(fromDateTime) ?? false;
    final isBefore = date.isBeforeOrEqualTo(toDateTime) ?? false;
    return isAfter && isBefore;
  }

  DateTime previous(int day) {
    if (day == weekday) {
      return subtract(const Duration(days: 7));
    } else {
      return subtract(
        Duration(
          days: (weekday - day) % DateTime.daysPerWeek,
        ),
      );
    }
  }

  bool isFirstDay(int weekday) {
    return DateTime(year, month, 1).weekday == weekday;
  }

  bool isFirstDayMonday() {
    return DateTime(year, month, 1).weekday == DateTime.monday;
  }

  bool isWeekend() {
    return weekday == DateTime.saturday || weekday == DateTime.sunday;
  }

  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
