import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/standard_calendar/model/calendar_config_model.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_month_selection_bar.dart';
import 'package:mobkit_date_picker/src/standard_calendar/standard_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'month_and_year_calendar/model/month_and_year_config_model.dart';
import 'month_and_year_calendar/month_and_year_picker.dart';

class StandardCalendar extends StatelessWidget {
  late final ValueNotifier<DateTime> calendarDate;
  late final ValueNotifier<DateTime> selectedDate;
  late final ValueNotifier<List<DateTime>> selectedDates;
  final StandardCalendarConfigModel? config;

  StandardCalendar(DateTime calendarDate, DateTime? selectedDate, List<DateTime>? selectedDates,
      {Key? key, this.config})
      : super(key: key) {
    this.calendarDate = ValueNotifier<DateTime>(calendarDate);
    this.selectedDate = ValueNotifier<DateTime>(selectedDate ?? DateTime.now());
    this.selectedDates = ValueNotifier<List<DateTime>>(selectedDates ?? List<DateTime>.from([]));
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    var months = MonthSelectionBar(calendarDate);
    return StandardPicker(
        config: config,
        months: months,
        calendarDate: calendarDate,
        selectedDate: selectedDate,
        selectedDates: selectedDates);
  }
}

class MonthAndYearCalendar extends StatelessWidget {
  late final ValueNotifier<DateTime> calendarDate;
  final MonthAndYearConfigModel? config;
  late final ValueNotifier<DateTime> selectedDate;
  late final ValueNotifier<List<DateTime>> selectedDates;
  MonthAndYearCalendar(DateTime calendarDate, DateTime? selectedDate, List<DateTime>? selectedDates,
      {Key? key, this.config})
      : super(key: key) {
    this.calendarDate = ValueNotifier<DateTime>(calendarDate);
    this.selectedDate = ValueNotifier<DateTime>(selectedDate ?? DateTime.now());
    this.selectedDates = ValueNotifier<List<DateTime>>(selectedDates ?? List<DateTime>.from([]));
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    return MonthAndYearPicker(
        monthAndYearConfigModel: config,
        calendarDate: calendarDate,
        selectedDate: selectedDate,
        selectedDates: selectedDates);
  }
}
