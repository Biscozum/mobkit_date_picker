import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/mobkit_date_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MonthAndYearCalendar? monthAndYearCalendar;
  StandardCalendar? standardCalendar;
  Future<void> pickDateModalMonthAndYear(
      BuildContext context, String textIconTitleText, MonthAndYearSelectionType type) {
    monthAndYearCalendar = MonthAndYearCalendar(
      DateTime.now(),
      null,
      null,
      config: MonthAndYearConfigModel(selectionType: type),
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

  Future<void> pickDateModalStandardCalendar(BuildContext context, String textIconTitleText, SelectionType type) {
    standardCalendar = StandardCalendar(
      DateTime.now(),
      null,
      null,
      config: StandardCalendarConfigModel(selectionType: type),
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

  String? dates;
  String? date;

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
                pickDateModalMonthAndYear(context, "Tarih", MonthAndYearSelectionType.selectionScroll)
                    .whenComplete(() async {
                  setState(() {
                    date = monthAndYearCalendar?.calendarDate.value.toString();
                  });
                });
              },
              child: const Text(
                "MonthAndYearCalendar selectionScroll",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, "Tarih", MonthAndYearSelectionType.selectionRange)
                    .whenComplete(() async {
                  setState(() {
                    date = monthAndYearCalendar?.selectedDate.value.toString();
                  });
                });
              },
              child: const Text(
                "MonthAndYearCalendar selectionRange",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalMonthAndYear(context, "Tarih", MonthAndYearSelectionType.selectionSingle)
                    .whenComplete(() async {
                  setState(() {
                    date = monthAndYearCalendar?.selectedDate.value.toString();
                  });
                });
              },
              child: const Text(
                "MonthAndYearCalendar selectionSingle",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalStandardCalendar(context, "Tarih", SelectionType.rangeTap).whenComplete(() async {
                  setState(() {
                    date = standardCalendar?.selectedDate.value.toString();
                  });
                });
              },
              child: const Text(
                "StandardCalendar range tap",
              ),
            ),
            TextButton(
              onPressed: () {
                pickDateModalStandardCalendar(context, "Tarih", SelectionType.singleTap).whenComplete(() async {
                  setState(() {
                    date = standardCalendar?.selectedDate.value.toString();
                  });
                });
              },
              child: const Text(
                "StandardCalendar single tap",
              ),
            ),
            Text(date.toString()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => const CalendarPage()),
          // );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
