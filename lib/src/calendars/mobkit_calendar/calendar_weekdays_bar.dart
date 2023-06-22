import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../mobkit_date_picker.dart';
import 'calendar_cell.dart';

class CalendarWeekDaysBar extends StatelessWidget {
  const CalendarWeekDaysBar({Key? key, this.config, required this.customCalendarModel}) : super(key: key);
  final MobkitCalendarConfigModel? config;
  final List<MobkitCalendarAppointmentModel> customCalendarModel;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _getWeekDays(DateTime.monday)
          .map((e) => CalendarCellWidget(
                e,
                isWeekDaysBar: true,
                standardCalendarConfig: config,
              ))
          .toList(),
    );
  }

  List<String> _getWeekDays(int weekStart) {
    List<String> weekdays = [];
    for (var i = 0; i < 7; i++) {
      weekdays.add(DateFormat.d(config?.locale ?? 'tr').dateSymbols.SHORTWEEKDAYS[(i + weekStart) % 7]);
    }
    return weekdays;
  }
}
