import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/mobkit_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MobkitMonthAndYearCalendar? monthAndYearCalendar;
  MobkitCalendar? calendar;

  Future<void> pickDateModalMonthAndYear(BuildContext context, MobkitMonthAndYearCalendarSelectionType type) {
    monthAndYearCalendar = MobkitMonthAndYearCalendar(
      selectedDate: null,
      calendarDate: DateTime.now(),
      config: MobkitMonthAndYearCalendarConfigModel(
        selectionType: type,
        locale: 'en_EN',
      ),
      onSelectionChange: (value) {
        setState(() {
          date = value.toString();
        });
      },
      onRangeSelectionChange: (firstDate, lastDate) {
        setState(() {
          firstDateStr = firstDate.toString();
          lastDateStr = lastDate.toString();
        });
      },
    );
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context1) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
            child: SizedBox(
              child: monthAndYearCalendar,
            ));
      },
    );
  }

  Future<void> pickDateModalCalendar(BuildContext context, MobkitCalendarSelectionType type) {
    calendar = MobkitCalendar(
      selectedDate: null,
      calendarDate: DateTime.now(),
      config: MobkitCalendarConfigModel(selectionType: type, locale: 'en_EN'),
      onSelectionChange: (value) {
        setState(() {
          date = value.toString();
        });
      },
      onRangeSelectionChange: (firstDate, lastDate) {
        setState(() {
          firstDateStr = firstDate.toString();
          lastDateStr = lastDate.toString();
        });
      },
    );
    return showModalBottomSheet<void>(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context1) {
        return Container(
            height: MediaQuery.of(context).size.height * 0.80,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0))),
            child: SizedBox(
              child: calendar,
            ));
      },
    );
  }

  String firstDateStr = "";
  String lastDateStr = "";
  String date = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, MobkitMonthAndYearCalendarSelectionType.selectionScroll);
              },
              child: const Text(
                "MonthAndYearCalendar selectionScroll",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, MobkitMonthAndYearCalendarSelectionType.selectionRange);
              },
              child: const Text(
                "MonthAndYearCalendar selectionRange",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, MobkitMonthAndYearCalendarSelectionType.selectionSingle);
              },
              child: const Text(
                "MonthAndYearCalendar selectionSingle",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalCalendar(context, MobkitCalendarSelectionType.rangeTap);
              },
              child: const Text(
                "Calendar range tap",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalCalendar(context, MobkitCalendarSelectionType.singleTap);
              },
              child: const Text(
                "Calendar single tap",
              ),
            ),
            const Text("SelectedDate"),
            const SizedBox(
              height: 10,
            ),
            Text(date.toString()),
            const SizedBox(
              height: 10,
            ),
            const Text("FirstDate"),
            const SizedBox(
              height: 10,
            ),
            Text(firstDateStr.toString()),
            const SizedBox(
              height: 10,
            ),
            const Text("LastDate"),
            const SizedBox(
              height: 10,
            ),
            Text(lastDateStr.toString()),
          ],
        ),
      ),
    );
  }
}
