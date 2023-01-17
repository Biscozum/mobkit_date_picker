import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
import 'package:mobkit_date_picker/src/model/calendar_type_model.dart';
import 'package:intl/intl.dart';

import '../../mobkit_date_picker.dart';
import '../standard_calendar/calendar_cell.dart';

class MonthCell extends StatelessWidget {
  final DateTime date;
  final bool enabled;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<List<DateTime>> selectedDates;
  final MonthAndYearConfigModel? config;
  final bool isSelectedNew;
  final bool isFirstLastSelectedItem;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime, DateTime) onRangeSelectionChange;
  const MonthCell(this.date, this.isSelectedNew, this.isFirstLastSelectedItem, this.selectedDate, this.selectedDates,
      this.onRangeSelectionChange, this.onSelectionChange,
      {Key? key, this.config, this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEnabled = true;
    return ValueListenableBuilder(
        valueListenable: selectedDate,
        builder: (context, DateTime selectedDate, widget) {
          return config != null
              ? config!.selectionType == MonthAndYearSelectionType.selectionRange
                  ? CellWidget(
                      DateFormat('MMMM').format(DateTime(0, date.month, 1)),
                      isSelected: isSelectedNew,
                      isFirstLastSelectedItem: isFirstLastSelectedItem,
                      isCurrent: DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().format(date),
                      isEnabled: isEnabled,
                      monthAndYearConfig: config,
                      calendarType: CalendarType.monthAndYearCalendar,
                    )
                  : GestureDetector(
                      onTap: () {
                        this.selectedDate.value = date;
                        onSelectionChange(date);
                      },
                      child: CellWidget(
                        DateFormat('MMMM').format(DateTime(0, date.month)),
                        isSelected: selectedDate.isSameDay(date),
                        isCurrent: DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().format(date),
                        monthAndYearConfig: config,
                        calendarType: CalendarType.monthAndYearCalendar,
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    this.selectedDate.value = date;
                    onSelectionChange(date);
                  },
                  child: CellWidget(
                    DateFormat('MMMM').format(DateTime(0, date.month)),
                    isSelected: selectedDate.isSameDay(date),
                    isCurrent: DateFormat.yMd().format(DateTime.now()) == DateFormat.yMd().format(date),
                  ),
                );
        });
  }
}
