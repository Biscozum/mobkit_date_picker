import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
import 'package:mobkit_date_picker/src/pickers/standard_picker/picker_month_selection_bar.dart';
import 'package:mobkit_date_picker/src/pickers/standard_picker/standard_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../mobkit_date_picker.dart';
import 'calendars/mobkit_calendar/mobkit_calendar.dart';
import 'extensions/model/week_dates_model.dart';
import 'pickers/month_and_year_picker/month_and_year_picker.dart';

class MobkitPicker extends StatelessWidget {
  final DateTime calendarDate;
  late final DateTime selectDate;
  final ValueNotifier<List<DateTime>> selectedDates = ValueNotifier<List<DateTime>>(List<DateTime>.from([]));
  final MobkitPickerConfigModel? config;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime firstDate, DateTime lastDate) onRangeSelectionChange;
  MobkitPicker({
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
    var months = MonthSelectionBar(widgetCalendarDate, config);
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

class MobkitMonthAndYearCalendar extends StatelessWidget {
  final DateTime calendarDate;
  late final DateTime selectDate;
  final MobkitMonthAndYearCalendarConfigModel? config;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime firstDate, DateTime lastDate) onRangeSelectionChange;
  late final ValueNotifier<List<DateTime>> selectedDates = ValueNotifier<List<DateTime>>(List<DateTime>.from([]));
  MobkitMonthAndYearCalendar({
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

class MobkitCalendarWidget extends StatefulWidget {
  final DateTime calendarDate;
  late final DateTime selectDate;
  final MobkitCalendarConfigModel? config;
  final List<MobkitCalendarAppointmentModel> appointmentModel;
  final ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange;

  MobkitCalendarWidget({
    DateTime? selectedDate,
    Key? key,
    this.config,
    required this.onSelectionChange,
    required this.appointmentModel,
    required this.calendarDate,
  }) : super(key: key) {
    selectDate = selectedDate ?? DateTime.now();
  }

  @override
  State<MobkitCalendarWidget> createState() => _MobkitCalendarWidgetState();
}

class _MobkitCalendarWidgetState extends State<MobkitCalendarWidget> {
  late final ValueNotifier<List<DateTime>> selectedDates = ValueNotifier<List<DateTime>>(List<DateTime>.from([]));
  List<MobkitCalendarAppointmentModel> lastAppointments = [];
  bool isLoadData = false;

  parseAppointmentModel() {
    if (widget.appointmentModel.isNotEmpty && !isLoadData) {
      List<MobkitCalendarAppointmentModel> withRecurrencyAppointments = [];
      List<MobkitCalendarAppointmentModel> addNewAppointments = [];
      if (widget.appointmentModel.where((element) => element.recurrenceModel != null).isNotEmpty) {
        withRecurrencyAppointments =
            widget.appointmentModel.where((element) => element.recurrenceModel != null).toList();
        for (int i = 0; i < withRecurrencyAppointments.length; i++) {
          addNewAppointments = [];
          if (withRecurrencyAppointments[i].recurrenceModel != null) {
            //Günlük tekrar döngüsü
            if (withRecurrencyAppointments[i].recurrenceModel!.frequency is DailyFrequency) {
              for (int y = 1; y < withRecurrencyAppointments[i].recurrenceModel!.interval + 1; y++) {
                MobkitCalendarAppointmentModel addAppointmentModel = MobkitCalendarAppointmentModel(
                    title: withRecurrencyAppointments[i].title,
                    appointmentStartDate: withRecurrencyAppointments[i].appointmentStartDate.add(Duration(days: y)),
                    appointmentEndDate: withRecurrencyAppointments[i].appointmentStartDate.add(Duration(days: y)),
                    color: withRecurrencyAppointments[i].color,
                    isAllDay: withRecurrencyAppointments[i].isAllDay,
                    detail: withRecurrencyAppointments[i].detail,
                    recurrenceModel: null);
                addNewAppointments.add(addAppointmentModel);
              }
            }
            //Haftalık tekrar döngüsü
            if (withRecurrencyAppointments[i].recurrenceModel!.frequency is WeeklyFrequency) {
              List<int> dayOfWeekList =
                  (withRecurrencyAppointments[i].recurrenceModel!.frequency as WeeklyFrequency).daysOfWeek;
              int interval = withRecurrencyAppointments[i].recurrenceModel!.interval;
              WeekDates weekDates = getDatesFromWeekNumber(
                  withRecurrencyAppointments[i].appointmentStartDate.year,
                  withRecurrencyAppointments[i]
                      .appointmentEndDate
                      .weekNumber(withRecurrencyAppointments[i].appointmentEndDate));
              for (int y = 1; y < interval + 1; y++) {
                List<DateTime> betweenDays = getDaysInBetween(
                    weekDates.from.add(Duration(days: y * 7)), weekDates.to.add(Duration(days: y * 7)));
                if (withRecurrencyAppointments[i]
                    .recurrenceModel!
                    .endDate
                    .isAfter(weekDates.from.add(Duration(days: y * 7)))) {
                  for (int d = 0; d < dayOfWeekList.length; d++) {
                    for (int k = 0; k < betweenDays.length; k++) {
                      if (betweenDays[k].weekday == dayOfWeekList[d]) {
                        MobkitCalendarAppointmentModel addAppointmentModel = MobkitCalendarAppointmentModel(
                            title: withRecurrencyAppointments[i].title,
                            appointmentStartDate: betweenDays[k],
                            appointmentEndDate: betweenDays[k],
                            color: withRecurrencyAppointments[i].color,
                            isAllDay: withRecurrencyAppointments[i].isAllDay,
                            detail: withRecurrencyAppointments[i].detail,
                            recurrenceModel: null);
                        addNewAppointments.add(addAppointmentModel);
                      }
                    }
                  }
                }
              }
            }

            //Aylik tekrar döngüsü
            if (withRecurrencyAppointments[i].recurrenceModel!.frequency is MonthlyFrequency) {
              for (int y = 1; y < withRecurrencyAppointments[i].recurrenceModel!.interval + 1; y++) {
                if (((withRecurrencyAppointments[i].recurrenceModel!.frequency as MonthlyFrequency)
                    .monthlyFrequencyType) is DaysOfMonthModel) {
                  List<int> daysOfMonthList =
                      (((withRecurrencyAppointments[i].recurrenceModel!.frequency as MonthlyFrequency)
                              .monthlyFrequencyType) as DaysOfMonthModel)
                          .daysOfMonth;
                  DateTime changedDate = addMonth(withRecurrencyAppointments[i].appointmentStartDate, y);
                  if (withRecurrencyAppointments[i].recurrenceModel!.endDate.isAfter(changedDate)) {
                    for (int k = 0; k < daysOfMonthList.length; k++) {
                      MobkitCalendarAppointmentModel addAppointmentModel = MobkitCalendarAppointmentModel(
                          title: withRecurrencyAppointments[i].title,
                          appointmentStartDate: DateTime(changedDate.year, changedDate.month, daysOfMonthList[k]),
                          appointmentEndDate: DateTime(changedDate.year, changedDate.month, daysOfMonthList[k]),
                          color: withRecurrencyAppointments[i].color,
                          isAllDay: withRecurrencyAppointments[i].isAllDay,
                          detail: withRecurrencyAppointments[i].detail,
                          recurrenceModel: null);
                      addNewAppointments.add(addAppointmentModel);
                    }
                  }
                } else if (((withRecurrencyAppointments[i].recurrenceModel!.frequency as MonthlyFrequency)
                    .monthlyFrequencyType) is DayOfWeekAndRepetitionModel) {
                  MapEntry<int, int> dayOfMonthAndRepetition =
                      (((withRecurrencyAppointments[i].recurrenceModel!.frequency as MonthlyFrequency)
                              .monthlyFrequencyType) as DayOfWeekAndRepetitionModel)
                          .dayOfMonthAndRepetition;
                  DateTime changedDate = addMonth(withRecurrencyAppointments[i].appointmentStartDate, y);
                  if (withRecurrencyAppointments[i].recurrenceModel!.endDate.isAfter(changedDate)) {
                    int monthDays = DateUtils.getDaysInMonth(changedDate.year, changedDate.month);
                    int repetition = 0;
                    for (int d = 1; d < monthDays; d++) {
                      if (dayOfMonthAndRepetition.key == DateTime(changedDate.year, changedDate.month, d).weekday) {
                        repetition++;
                        if (repetition == dayOfMonthAndRepetition.value) {
                          addNewAppointments.add(MobkitCalendarAppointmentModel(
                              title: withRecurrencyAppointments[i].title,
                              appointmentStartDate: DateTime(changedDate.year, changedDate.month, d),
                              appointmentEndDate: DateTime(changedDate.year, changedDate.month, d),
                              color: withRecurrencyAppointments[i].color,
                              isAllDay: withRecurrencyAppointments[i].isAllDay,
                              detail: withRecurrencyAppointments[i].detail,
                              recurrenceModel: null));
                        }
                      }
                    }
                  }
                }
              }
            }
            lastAppointments.addAll(addNewAppointments);
          } else {
            continue;
          }
        }
        lastAppointments.addAll(widget.appointmentModel);
      }
      setState(() {
        isLoadData = true;
      });
    }
  }

  @override
  void initState() {
    parseAppointmentModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<DateTime> widgetCalendarDate = ValueNotifier<DateTime>(widget.calendarDate);
    ValueNotifier<DateTime> widgetSelectedDate = ValueNotifier<DateTime>(widget.selectDate);
    initializeDateFormatting();
    return isLoadData
        ? MobkitCalendar(
            config: widget.config,
            appointmentModel: lastAppointments,
            selectedDate: widgetSelectedDate,
            calendarDate: widgetCalendarDate,
            onSelectionChange: widget.onSelectionChange,
          )
        : const CircularProgressIndicator();
  }
}
