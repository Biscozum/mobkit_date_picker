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

  @override
  Widget build(BuildContext context) {
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
            ? const SizedBox(
                height: 24,
              )
            : Container(),
        config?.mobkitCalendarViewType == MobkitCalendarViewType.daily
            ? ValueListenableBuilder(
                valueListenable: selectedDate,
                builder: (_, DateTime date, __) {
                  List<MobkitCalendarAppointmentModel> model = appointmentModel
                      .where((element) =>
                          (DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
                                  .isBetween(element.appointmentStartDate, element.appointmentEndDate) ??
                              false) ||
                          DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
                              .isSameDay(element.appointmentStartDate))
                      .toList();

                  return Expanded(
                    child: ListView.builder(
                      itemCount: 23,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        List<MobkitCalendarAppointmentModel> list = model
                            .where((element) =>
                                (!element.isAllDay) &&
                                (DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day,
                                            index + 1)
                                        .isBetween(element.appointmentStartDate, element.appointmentEndDate) ??
                                    false) &&
                                (DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day,
                                            index + 1)
                                        .hour !=
                                    element.appointmentEndDate.hour))
                            .toList();
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, right: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${(index + 1).toString()}:00",
                                style: const TextStyle(color: Colors.black, fontSize: 18),
                              ),
                              Column(
                                children: [
                                  list.isNotEmpty
                                      ? Container()
                                      : Padding(
                                          padding: const EdgeInsets.only(top: 12),
                                          child: SizedBox(
                                            width: MediaQuery.of(context).size.width * 0.8,
                                            child: const Divider(
                                              thickness: 1,
                                              height: 1,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                  list.isNotEmpty
                                      ? SizedBox(
                                          width: MediaQuery.of(context).size.width * 0.8,
                                          height: 60,
                                          child: ListView.builder(
                                            itemCount: list.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index1) {
                                              return SizedBox(
                                                width: (MediaQuery.of(context).size.width * 0.8) / list.length,
                                                child: Container(
                                                  width: MediaQuery.of(context).size.width * 0.8,
                                                  color: list[index1].color,
                                                  child: Align(
                                                    alignment: Alignment.topLeft,
                                                    child: Text(
                                                      list[index1].title,
                                                      style: TextStyle(color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        )
                                      : SizedBox(
                                          height: 60,
                                          width: MediaQuery.of(context).size.width * 0.8,
                                        )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              )
            : Container(),
      ],
    );
  }
}
