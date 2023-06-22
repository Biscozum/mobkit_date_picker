import 'frequency_model.dart';

class RecurrenceModel {
  Frequency frequency;
  DateTime endDate;
  int interval;
  RecurrenceModel({
    required this.frequency,
    required this.endDate,
    required this.interval,
  });
}

class DailyFrequency extends Frequency {
  // Günlük tekrar
  DailyFrequency();
}

class WeeklyFrequency extends Frequency {
  // Haftalık tekrarda haftanın hangi günleri
  List<int> daysOfWeek;
  WeeklyFrequency({
    required this.daysOfWeek,
  });
}

class MonthlyFrequency extends Frequency {
  dynamic monthlyFrequencyType;
  MonthlyFrequency({
    required this.monthlyFrequencyType,
  });
}

class DaysOfMonthModel {
  // Aylık tekrarda ayın kaçıncı günleri
  List<int> daysOfMonth;
  DaysOfMonthModel({
    required this.daysOfMonth,
  });
}

class DayOfWeekAndRepetitionModel {
  // Aylık tekrarda ayın hangi günü ve kaçıncı tekrar
  MapEntry<int, int> dayOfMonthAndRepetition;
  DayOfWeekAndRepetitionModel({
    required this.dayOfMonthAndRepetition,
  });
}

class YearlyFrequency extends Frequency {
  // Yıllık tekrar
  YearlyFrequency();
}
