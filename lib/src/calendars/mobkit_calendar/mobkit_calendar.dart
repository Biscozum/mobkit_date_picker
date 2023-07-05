import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/calendar_date_bar.dart';
import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/model/mobkit_calendar_appointment_model.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
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

  bool? isIntersect(
    DateTime firstStartDate,
    DateTime firstEndDate,
    DateTime secondStartDate,
    DateTime secondEndDate,
  ) {
    return (secondStartDate.isBetween(firstStartDate, firstEndDate.add(const Duration(minutes: -1))) ?? false) ||
        (secondEndDate
                .add(const Duration(minutes: -1))
                .isBetween(firstStartDate, firstEndDate.add(const Duration(minutes: -1))) ??
            false) ||
        (firstStartDate.isBetween(secondStartDate, secondEndDate.add(const Duration(minutes: -1))) ?? false) ||
        (firstEndDate
                .add(const Duration(minutes: -1))
                .isBetween(secondStartDate, secondEndDate.add(const Duration(minutes: -1))) ??
            false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int maxGroupCount = 0;
    return Column(
      mainAxisSize: MainAxisSize.max,
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
              Expanded(flex: 6, child: CalendarYearSelectionBar(calendarDate, config)),
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
        Container(
            color: Colors.transparent,
            child: DateSelectionBar(
              calendarDate,
              selectedDate,
              onSelectionChange: onSelectionChange,
              customCalendarModel: appointmentModel,
              config: config,
            )),
        config?.mobkitCalendarViewType == MobkitCalendarViewType.daily
            ? ValueListenableBuilder(
                valueListenable: selectedDate,
                builder: (_, DateTime date, __) {
                  List<MobkitCalendarAppointmentModel> modelList = appointmentModel
                      .where((element) =>
                          (DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
                                  .isBetween(element.appointmentStartDate, element.appointmentEndDate) ??
                              false) ||
                          DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
                              .isSameDay(element.appointmentStartDate))
                      .toList();
                  modelList.sort((a, b) => a.appointmentStartDate.compareTo(b.appointmentStartDate));
                  if (modelList.isNotEmpty) {
                    for (var item in modelList) {
                      if (modelList.indexOf(item) == 0) {
                        item.index = 0;
                        maxGroupCount = 1;
                      } else {
                        var indexOfData = 0;
                        List<int> groupIndex = [];
                        for (int i = 0; i < modelList.indexOf(item); i++) {
                          if (isIntersect(item.appointmentStartDate, item.appointmentEndDate,
                                  modelList[i].appointmentStartDate, modelList[i].appointmentEndDate) ??
                              false) {
                            groupIndex.add((modelList[i].index ?? 0));
                            while (groupIndex.contains(indexOfData)) {
                              ++indexOfData;
                            }
                          }
                        }
                        item.index = indexOfData;
                        maxGroupCount = indexOfData + 1 > maxGroupCount ? indexOfData + 1 : maxGroupCount;
                      }
                    }
                  }
                  return Expanded(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: List<Widget>.generate(
                          modelList.length,
                          (i) {
                            return Positioned(
                              top: (80 *
                                              (modelList[i].appointmentStartDate.hour +
                                                  (modelList[i].appointmentStartDate.minute / 60)))
                                          .toDouble() !=
                                      0
                                  ? (80 *
                                              (modelList[i].appointmentStartDate.hour +
                                                  (modelList[i].appointmentStartDate.minute / 60)))
                                          .toDouble() +
                                      9
                                  : (80 *
                                          (modelList[i].appointmentStartDate.hour +
                                              (modelList[i].appointmentStartDate.minute / 60)))
                                      .toDouble(),
                              left: 58.5 +
                                  ((modelList[i].index ?? 0) > 0
                                      ? ((width * 0.8) / maxGroupCount) * (modelList[i].index ?? 0)
                                      : 0),
                              width: (width * 0.8) / (maxGroupCount),
                              height: modelList[i].appointmentEndDate.hour != 0
                                  ? (((modelList[i]
                                              .appointmentEndDate
                                              .difference(modelList[i].appointmentStartDate)
                                              .inMinutes) /
                                          60) *
                                      80)
                                  : modelList[i]
                                          .appointmentEndDate
                                          .difference(modelList[i].appointmentStartDate)
                                          .inHours *
                                      80,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 1.5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: modelList[i].color,
                                    borderRadius: const BorderRadius.all(Radius.circular(1)),
                                  ),
                                  child: Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      modelList[i].title,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )..insert(
                            0,
                            Column(
                              children: List<Widget>.generate(
                                24,
                                (index) {
                                  if (index == 0) {
                                    return const SizedBox(
                                      height: 80,
                                    );
                                  } else {
                                    return Container(
                                      alignment: Alignment.topCenter,
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 12, right: 12),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              "${(index).toString()}:00",
                                              style: const TextStyle(color: Colors.black, fontSize: 18),
                                            ),
                                            Container(
                                              width: width * 0.8,
                                              color: Colors.grey,
                                              height: 1,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                      ),
                    ),
                  );
                },
              )
            : Container(),
      ],
    );
  }
}