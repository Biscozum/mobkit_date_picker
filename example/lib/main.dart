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
  MonthAndYearCalendar? monthAndYearCalendar;
  StandardCalendar? standardCalendar;

  Future<void> pickDateModalMonthAndYear(BuildContext context, MonthAndYearSelectionType type) {
    monthAndYearCalendar = MonthAndYearCalendar(
      selectedDate: null,
      calendarDate: DateTime.now(),
      config: MonthAndYearConfigModel(
        selectionType: type,
        isFirstLastItemColor: Colors.pink,
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

  Future<void> pickDateModalStandardCalendar(BuildContext context, SelectionType type) {
    standardCalendar = StandardCalendar(
      selectedDate: null,
      calendarDate: DateTime.now(),
      config: StandardCalendarConfigModel(
        selectionType: type,
        isFirstLastItemColor: Colors.green,
        enabledColor: Colors.blue,
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
              child: standardCalendar,
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
                pickDateModalMonthAndYear(context, MonthAndYearSelectionType.selectionScroll);
              },
              child: const Text(
                "MonthAndYearCalendar selectionScroll",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, MonthAndYearSelectionType.selectionRange);
              },
              child: const Text(
                "MonthAndYearCalendar selectionRange",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, MonthAndYearSelectionType.selectionSingle);
              },
              child: const Text(
                "MonthAndYearCalendar selectionSingle",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalStandardCalendar(context, SelectionType.rangeTap);
              },
              child: const Text(
                "StandardCalendar range tap",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalStandardCalendar(context, SelectionType.singleTap);
              },
              child: const Text(
                "StandardCalendar single tap",
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
