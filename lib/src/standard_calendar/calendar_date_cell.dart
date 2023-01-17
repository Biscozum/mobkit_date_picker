import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
import 'package:mobkit_date_picker/src/model/calendar_type_model.dart';
import 'package:intl/intl.dart';

import 'calendar_cell.dart';
import 'model/calendar_config_model.dart';

class DateCell extends StatelessWidget {
  final DateTime date;
  final bool enabled;
  final ValueNotifier<DateTime> selectedDate;
  final StandardCalendarConfigModel? config;
  final bool isSelectedNew;
  final bool isFirstLastSelectedItem;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime, DateTime) onRangeSelectionChange;
  const DateCell(this.date, this.isSelectedNew, this.isFirstLastSelectedItem, this.selectedDate, this.onSelectionChange,
      this.onRangeSelectionChange,
      {Key? key, this.config, this.enabled = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isEnabled = enabled && checkIsEnableDate(date);
    return ValueListenableBuilder(
        valueListenable: selectedDate,
        builder: (context, DateTime selectedDate, widget) {
          return config != null
              ? config!.selectionType == SelectionType.rangeTap
                  ? CellWidget(
                      date.day.toString(),
                      isSelected: isSelectedNew,
                      isFirstLastSelectedItem: isFirstLastSelectedItem,
                      isEnabled: isEnabled,
                      standardCalendarConfig: config,
                      calendarType: CalendarType.standardCalendar,
                      isCurrent: DateFormat.yMd().format(selectedDate) == DateFormat.yMd().format(date),
                    )
                  : GestureDetector(
                      onTap: () {
                        if (isEnabled) {
                          this.selectedDate.value = date;
                          onSelectionChange(date);
                        }
                      },
                      child: CellWidget(
                        date.day.toString(),
                        isSelected: selectedDate.isSameDay(date),
                        isEnabled: isEnabled,
                        standardCalendarConfig: config,
                        calendarType: CalendarType.standardCalendar,
                        isCurrent: DateFormat.yMd().format(selectedDate) == DateFormat.yMd().format(date),
                      ),
                    )
              : GestureDetector(
                  onTap: () {
                    if (isEnabled) {
                      this.selectedDate.value = date;
                      onSelectionChange(date);
                    }
                  },
                  child: CellWidget(
                    date.day.toString(),
                    isSelected: selectedDate.isSameDay(date),
                    isEnabled: isEnabled,
                    standardCalendarConfig: config,
                    isCurrent: DateFormat.yMd().format(selectedDate) == DateFormat.yMd().format(date),
                    calendarType: CalendarType.standardCalendar,
                  ),
                );
        });
  }

  bool checkIsEnableDate(DateTime date) {
    if (config != null) {
      if (config?.disableBefore != null && date.isBefore(config!.disableBefore!)) return false;

      if (config?.disableAfter != null && date.isAfter(config!.disableAfter!)) {
        return false;
      }
      if (config?.disabledDates != null && config!.disabledDates!.any((element) => element.isSameDay(date))) {
        return false;
      }
    }
    return true;
  }
}
