import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/standard_calendar/model/calendar_config_model.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_month_selection_bar.dart';
import 'package:mobkit_date_picker/src/standard_calendar/standard_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'month_and_year_calendar/model/month_and_year_config_model.dart';
import 'month_and_year_calendar/month_and_year_picker.dart';

class StandardCalendar extends StatelessWidget {
  final DateTime calendarDate;
  late final DateTime selectDate;
  final ValueNotifier<List<DateTime>> selectedDates = ValueNotifier<List<DateTime>>(List<DateTime>.from([]));
  final StandardCalendarConfigModel? config;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime firstDate, DateTime lastDate) onRangeSelectionChange;
  StandardCalendar({
    DateTime? selectedDate,
    Key? key,
    this.config,
    required this.onSelectionChange,
    required this.onRangeSelectionChange,
    required this.calendarDate,
  }) : super(key: key) {
    selectDate = selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    ValueNotifier<DateTime> widgetCalendarDate = ValueNotifier<DateTime>(calendarDate);
    ValueNotifier<DateTime> widgetSelectedDate = ValueNotifier<DateTime>(selectDate);
    var months = MonthSelectionBar(widgetCalendarDate);
    return StandardPicker(
      config: config,
      months: months,
      calendarDate: widgetCalendarDate,
      selectedDate: widgetSelectedDate,
      selectedDates: selectedDates,
      onSelectionChange: onSelectionChange,
      onRangeSelectionChange: onRangeSelectionChange,
    );
  }
}

class MonthAndYearCalendar extends StatelessWidget {
  final DateTime calendarDate;
  late final DateTime selectDate;
  final MonthAndYearConfigModel? config;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime firstDate, DateTime lastDate) onRangeSelectionChange;
  late final ValueNotifier<List<DateTime>> selectedDates = ValueNotifier<List<DateTime>>(List<DateTime>.from([]));
  MonthAndYearCalendar({
    DateTime? selectedDate,
    Key? key,
    this.config,
    required this.onSelectionChange,
    required this.onRangeSelectionChange,
    required this.calendarDate,
  }) : super(key: key) {
    selectDate = selectedDate ?? DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();
    ValueNotifier<DateTime> widgetCalendarDate = ValueNotifier<DateTime>(calendarDate);
    ValueNotifier<DateTime> widgetSelectedDate = ValueNotifier<DateTime>(selectDate);
    return MonthAndYearPicker(
        monthAndYearConfigModel: config,
        onSelectionChange: onSelectionChange,
        onRangeSelectionChange: onRangeSelectionChange,
        calendarDate: widgetCalendarDate,
        selectedDate: widgetSelectedDate,
        selectedDates: selectedDates);
  }
}
