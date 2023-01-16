import 'package:flutter/material.dart';
import 'package:infact_calendar/infact_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late StandardCalendar vidgetCalendar;
  @override
  void initState() {
    CalendarConfigModel calendarConfigModel = CalendarConfigModel();
    calendarConfigModel.dateSelectType = SelectionType.rangeTap;
    vidgetCalendar = StandardCalendar(
      DateTime.now(),
      null,
      null,
      config: calendarConfigModel,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
          height: MediaQuery.of(context).size.height * 0.80,
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
          child: Column(
            children: [
              const SizedBox(
                height: 35,
              ),
              Container(
                child: vidgetCalendar,
              ),
              Text(vidgetCalendar.selectedDates.value.first.toString())
            ],
          )),
    );
  }
}
