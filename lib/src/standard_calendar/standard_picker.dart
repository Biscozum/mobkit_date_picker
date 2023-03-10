import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/standard_calendar/model/calendar_config_model.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_date_selection_bar.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_header.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_month_selection_bar.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_weekdays_bar.dart';
import 'package:mobkit_date_picker/src/standard_calendar/calendar_year_selection_bar.dart';

class StandardPicker extends StatelessWidget {
  const StandardPicker({
    Key? key,
    required this.config,
    required this.months,
    required this.calendarDate,
    required this.selectedDate,
    required this.selectedDates,
    required this.onSelectionChange,
    required this.onRangeSelectionChange,
  }) : super(key: key);

  final MobkitCalendarConfigModel? config;
  final MonthSelectionBar months;
  final ValueNotifier<DateTime> calendarDate;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<List<DateTime>> selectedDates;
  final ValueChanged<DateTime> onSelectionChange;
  final Function(DateTime, DateTime) onRangeSelectionChange;
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
              Expanded(flex: 8, child: months),
              const SizedBox(
                width: 10,
              ),
              Expanded(flex: 6, child: YearSelectionBar(calendarDate)),
            ],
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        WeekDaysBar(
          config: config,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
            height: 290,
            child: Container(
                color: Colors.transparent,
                child: DateSelectionBar(
                  calendarDate,
                  selectedDate,
                  selectedDates,
                  config: config,
                  onSelectionChange: onSelectionChange,
                  onRangeSelectionChange: onRangeSelectionChange,
                ))),
      ],
    );
  }
}
