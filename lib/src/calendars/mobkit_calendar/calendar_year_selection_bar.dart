import 'package:flutter/material.dart';

import 'calendar_buttons.dart';

class CalendarYearSelectionBar extends StatelessWidget {
  final ValueNotifier<DateTime> calendarDate;
  final double _itemSpace = 14;
  const CalendarYearSelectionBar(this.calendarDate, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CalendarBackButton(goPreviousYear),
        SizedBox(
          width: _itemSpace,
        ),
        ValueListenableBuilder(
            valueListenable: calendarDate,
            builder: (_, DateTime date, __) {
              return Text(
                date.year.toString(),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              );
            }),
        SizedBox(
          width: _itemSpace,
        ),
        CalendarForwardButton(goNextYear),
      ],
    );
  }

  changeYear(ValueNotifier<DateTime> calendarDate, int amount) {
    var newYear = calendarDate.value.year + amount;
    calendarDate.value = DateTime(newYear, calendarDate.value.month, calendarDate.value.day);
  }

  goNextYear() => changeYear(calendarDate, 1);

  goPreviousYear() => changeYear(calendarDate, -1);
}
