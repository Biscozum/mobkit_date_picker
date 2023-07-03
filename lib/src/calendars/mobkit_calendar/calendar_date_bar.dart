import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
import '../../../mobkit_date_picker.dart';
import 'calendar_date_cell.dart';

class DateSelectionBar extends StatefulWidget {
  final ValueNotifier<DateTime> date;
  final ValueNotifier<DateTime> selectedDate;

  final MobkitCalendarConfigModel? config;
  final List<MobkitCalendarAppointmentModel> customCalendarModel;
  final ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange;

  const DateSelectionBar(
    this.date,
    this.selectedDate, {
    Key? key,
    this.config,
    required this.customCalendarModel,
    required this.onSelectionChange,
  }) : super(key: key);

  @override
  State<DateSelectionBar> createState() => _DateSelectionBarState();
}

class _DateSelectionBarState extends State<DateSelectionBar> {
  changeWeek(ValueNotifier<DateTime> calendarDate, int amount) {
    DateTime firstWeekDay = findFirstDateOfTheWeek(calendarDate.value);
    calendarDate.value = firstWeekDay.add(Duration(days: amount));
  }

  goNextWeek() => changeWeek(widget.date, 7);
  goPreviousWeek() => changeWeek(widget.date, -7);

  @override
  Widget build(BuildContext context) {
    String? swipeDirection;
    return SizedBox(
      child: ValueListenableBuilder(
          valueListenable: widget.date,
          builder: (_, DateTime date, __) {
            return GestureDetector(
              onPanUpdate: (details) {
                swipeDirection = details.delta.dx < 0 ? 'left' : 'right';
              },
              onPanEnd: (details) {
                if (swipeDirection == 'left') {
                  goNextWeek();
                }
                if (swipeDirection == 'right') {
                  goPreviousWeek();
                }
              },
              child: DateList(
                config: widget.config,
                customCalendarModel: widget.customCalendarModel,
                date: date,
                selectedDate: widget.selectedDate,
                onSelectionChange: widget.onSelectionChange,
              ),
            );
          }),
    );
  }
}

class DateList extends StatefulWidget {
  final MobkitCalendarConfigModel? config;
  final List<MobkitCalendarAppointmentModel> customCalendarModel;
  final DateTime date;
  final ValueNotifier<DateTime> selectedDate;
  final ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange;

  const DateList(
      {Key? key,
      required this.date,
      required this.selectedDate,
      this.config,
      required this.customCalendarModel,
      required this.onSelectionChange})
      : super(key: key);

  @override
  State<DateList> createState() => _DateListState();
}

class _DateListState extends State<DateList> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      border: const TableBorder(
        horizontalInside: BorderSide(
          width: 0.5,
          color: Colors.grey,
        ),
      ),
      children: widget.config?.mobkitCalendarViewType == MobkitCalendarViewType.monthly
          ? getDatesMonthly(
              widget.date, widget.selectedDate, widget.onSelectionChange, widget.config, widget.customCalendarModel)
          : getDatesWeekly(
              widget.date, widget.selectedDate, widget.onSelectionChange, widget.config, widget.customCalendarModel),
    );
  }

  int calculateMonth(DateTime today) {
    final DateTime firstDayOfMonth = DateTime(today.year, today.month);
    return calculateWeekCount(firstDayOfMonth);
  }

  int calculateWeekCount(DateTime firstDay) {
    int weekCount = 0;
    final DateTime lastDayOfMonth = DateTime(firstDay.year, firstDay.month + 1, 0);
    DateTime date = firstDay;
    while (date.isBefore(lastDayOfMonth) || date == lastDayOfMonth) {
      weekCount++;
      date = date.next(DateTime.monday);
    }
    return weekCount;
  }

  List<TableRow> getDatesMonthly(
    DateTime date,
    ValueNotifier<DateTime> selectedDate,
    ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange,
    final MobkitCalendarConfigModel? config,
    final List<MobkitCalendarAppointmentModel> customCalendarModel,
  ) {
    List<TableRow> rowList = [];
    var firstDay = DateTime(date.year, date.month, 1);
    DateTime newDate = firstDay.isFirstDay(DateTime.monday) ? firstDay : firstDay.previous(DateTime.monday);
    for (var i = 0; i < calculateMonth(date); i++) {
      List<Widget> cellList = [];
      for (var x = 1; x <= 7; x++) {
        cellList.add(
          CalendarDateCell(
            newDate,
            selectedDate,
            onSelectionChange,
            customCalendarModel: customCalendarModel,
            config: config,
            enabled: true,
          ),
        );
        newDate = newDate.add(const Duration(days: 1));
      }
      rowList.add(TableRow(children: cellList));
    }
    return rowList;
  }

  List<TableRow> getDatesWeekly(
    DateTime date,
    ValueNotifier<DateTime> selectedDate,
    ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange,
    final MobkitCalendarConfigModel? config,
    final List<MobkitCalendarAppointmentModel> customCalendarModel,
  ) {
    List<TableRow> rowList = [];
    var firstDay = date.add(const Duration(days: 1));
    DateTime newDate = firstDay.isFirstDay(DateTime.monday) ? firstDay : firstDay.previous(DateTime.monday);
    for (var i = 0; i < 1; i++) {
      List<Widget> cellList = [];
      for (var x = 1; x <= 7; x++) {
        cellList.add(
          CalendarDateCell(
            newDate,
            selectedDate,
            onSelectionChange,
            customCalendarModel: customCalendarModel,
            config: config,
            enabled: true,
          ),
        );
        newDate = newDate.add(const Duration(days: 1));
      }
      rowList.add(TableRow(children: cellList));
    }
    return rowList;
  }

  bool checkConfigForEnable(DateTime newDate, DateTime date, MobkitCalendarConfigModel? config) {
    if (config == null) return false;
    if (config.disableBefore != null && date.isBefore(config.disableBefore!)) return false;

    if (config.disableAfter != null && date.isAfter(config.disableAfter!)) {
      return false;
    }
    if (config.disabledDates != null && config.disabledDates!.any((element) => element.isSameDay(date))) {
      return false;
    }
    if (newDate.isWeekend() && config.disableWeekendsDays) return false;
    if (newDate.month != date.month && config.disableOffDays) return false;
    return true;
  }
}
