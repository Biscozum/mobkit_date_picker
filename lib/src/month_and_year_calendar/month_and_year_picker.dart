import 'package:flutter/material.dart';
import '../standard_calendar/calendar_header.dart';
import '../standard_calendar/calendar_year_selection_bar.dart';
import 'month_and_year_bar_selection.dart';
import 'month_and_year_scroll_selection.dart';
import 'model/month_and_year_config_model.dart';

class MonthAndYearPicker extends StatelessWidget {
  late final MonthAndYearConfigModel config;
  final MonthAndYearConfigModel? monthAndYearConfigModel;
  final ValueNotifier<DateTime> calendarDate;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<List<DateTime>> selectedDates;
  MonthAndYearPicker({
    Key? key,
    required this.monthAndYearConfigModel,
    required this.calendarDate,
    required this.selectedDate,
    required this.selectedDates,
  }) : super(key: key) {
    if (monthAndYearConfigModel == null) {
      config = MonthAndYearConfigModel();
    } else {
      config = monthAndYearConfigModel!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (config.selectionType == MonthAndYearSelectionType.selectionScroll) {
      return MonthAndYearScrollSelection(calendarDate, config);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (config.title != null) Header(config.title!),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              YearSelectionBar(calendarDate),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          Expanded(
              child: MonthAndYearBarSelection(
            calendarDate,
            selectedDate,
            selectedDates,
            config: config,
          )),
        ],
      );
    }
  }
}
