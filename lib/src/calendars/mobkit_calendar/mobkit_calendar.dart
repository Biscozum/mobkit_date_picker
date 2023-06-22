import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/calendar_date_bar.dart';
import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/model/mobkit_calendar_appointment_model.dart';
import 'package:mobkit_date_picker/src/pickers/widgets/picker_header.dart';
import 'calendar_month_selection_bar.dart';
import 'calendar_weekdays_bar.dart';
import 'calendar_year_selection_bar.dart';
import 'model/calendar_config_model.dart';

class MobkitCalendar extends StatelessWidget {
  const MobkitCalendar({
    Key? key,
    required this.config,
    required this.appointmentModel,
    required this.calendarDate,
    required this.selectedDate,
    required this.onSelectionChange,
  }) : super(key: key);

  final MobkitCalendarConfigModel? config;
  final List<MobkitCalendarAppointmentModel> appointmentModel;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<DateTime> calendarDate;
  final ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (config?.title != null) Header(config!.title!),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: [
              Expanded(flex: 8, child: CalendarMonthSelectionBar(calendarDate, config)),
              const SizedBox(
                width: 10,
              ),
              Expanded(flex: 6, child: CalendarYearSelectionBar(calendarDate)),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        CalendarWeekDaysBar(
          config: config,
          customCalendarModel: appointmentModel,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 330,
            child: Container(
                color: Colors.transparent,
                child: DateSelectionBar(
                  calendarDate,
                  selectedDate,
                  onSelectionChange: onSelectionChange,
                  customCalendarModel: appointmentModel,
                  config: config,
                ))),
      ],
    );
  }
}
