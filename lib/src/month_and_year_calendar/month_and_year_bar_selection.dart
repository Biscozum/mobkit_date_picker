import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
import '../../mobkit_date_picker.dart';
import '../standard_calendar/datecell_renderobject.dart';
import 'month_cell.dart';

class MonthList extends StatefulWidget {
  final DateTime date;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<List<DateTime>> selectedDates;

  final MonthAndYearConfigModel? config;
  const MonthList(this.date, this.selectedDate, this.selectedDates, {Key? key, this.config}) : super(key: key);

  @override
  State<MonthList> createState() => _MonthListState();
}

class _MonthListState extends State<MonthList> {
  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: generateMonths(widget.date, widget.selectedDate, widget.config, widget.selectedDates),
    );
  }

  List<TableRow> generateMonths(DateTime date, ValueNotifier<DateTime> selectedDate,
      final MonthAndYearConfigModel? config, ValueNotifier<List<DateTime>> selectedDates) {
    List<TableRow> rowList = [];
    widget.selectedDates.value.sort((a, b) => a.compareTo(b));
    DateTime newDate = DateTime(date.year, 1, 1);
    for (var i = 1; i <= 4; i++) {
      List<Widget> months = [];
      for (int x = 1; x <= 3; x++) {
        DateTime dateTime = DateTime(DateTime.now().year, newDate.month, 1);
        months.add(
          Foo(
            index: dateTime.month,
            child: MonthCell(
              dateTime,
              selectedDates.value.contains(dateTime),
              selectedDates.value.isNotEmpty
                  ? selectedDates.value.first.month == dateTime.month
                      ? true
                      : false
                  : false,
              selectedDates.value.isNotEmpty
                  ? selectedDates.value.last.month == dateTime.month
                      ? true
                      : false
                  : false,
              selectedDate,
              selectedDates,
              config: widget.config,
            ),
          ),
        );
        newDate = DateTime(newDate.year, newDate.month + 1, 1);
      }
      rowList.length < 4 ? rowList.add(TableRow(children: months)) : null;
    }
    return rowList;
  }

  bool checkConfigForEnable(DateTime newDate, DateTime date, CalendarConfigModel? config) {
    if (config == null) return false;
    if (config.disableBefore != null && date.isBefore(config.disableBefore!)) return false;

    if (config.disableAfter != null && date.isAfter(config.disableAfter!)) {
      return false;
    }
    if (config.disabledDates != null && config.disabledDates!.any((element) => element.isSameDay(date))) {
      return false;
    }
    if (newDate.isWeekend() && !config.disableWeekendsDays) return true;
    if (newDate.month != date.month && !config.disableOffDays) return true;
    return false;
  }
}

class MonthAndYearBarSelection extends StatefulWidget {
  final ValueNotifier<DateTime> date;
  final ValueNotifier<DateTime> selectedDate;
  final ValueNotifier<List<DateTime>> selectedDates;
  final MonthAndYearConfigModel? config;
  const MonthAndYearBarSelection(this.date, this.selectedDate, this.selectedDates, {Key? key, this.config})
      : super(key: key);

  @override
  State<MonthAndYearBarSelection> createState() => _MonthAndYearBarSelectionState();
}

class _MonthAndYearBarSelectionState extends State<MonthAndYearBarSelection> {
  final key2 = GlobalKey();

  final Set<Foo2> _trackTaped = <Foo2>{};

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.selectedDate.value = DateTime(DateTime.now().year, DateTime.now().month, 1);
    });
    super.initState();
  }

  dateRangeTapItem(PointerEvent event) {
    final RenderBox box = key2.currentContext!.findRenderObject() as RenderBox;
    final result = BoxHitTestResult();
    Offset local = box.globalToLocal(event.position);
    if (box.hitTest(result, position: local)) {
      for (final hit in result.path) {
        final target = hit.target;
        if (target is Foo2) {
          _trackTaped.add(target);
          DateTime date = DateTime(widget.date.value.year, target.index, widget.date.value.day);
          _selectRange(date);
        }
      }
    }
  }

  Set<DateTime> getMonthsInBeteween(DateTime startDate, DateTime endDate) {
    Set<DateTime> months = <DateTime>{};
    while (startDate.isBefore(endDate)) {
      months.add(DateTime(startDate.year, startDate.month));
      startDate = DateTime(startDate.year, startDate.month + 1);
    }
    return months;
  }

  _selectRange(DateTime index) {
    if (widget.selectedDates.value.isNotEmpty) {
      if (widget.selectedDates.value.contains(index)) {
        widget.selectedDates.value.clear();
        widget.selectedDates.value.add(index);
      } else if (!widget.selectedDates.value.contains(index) && widget.selectedDates.value.length > 1) {
        widget.selectedDates.value.clear();
        widget.selectedDates.value.add(index);
      } else {
        if (widget.selectedDates.value.first.isBefore(index)) {
          widget.selectedDates.value.addAll(getMonthsInBeteween(widget.selectedDates.value.first, index));
        } else if (widget.selectedDates.value.first.isAfter(index)) {
          widget.selectedDates.value.addAll(getMonthsInBeteween(
            index,
            widget.selectedDates.value.first,
          ));
        }
      }
    } else {
      widget.selectedDates.value.add(index);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.config != null) {
      if (widget.config!.selectionType == MonthAndYearSelectionType.selectionRange) {
        return SizedBox(
          child: ValueListenableBuilder(
              valueListenable: widget.date,
              builder: (_, DateTime date, __) {
                return ValueListenableBuilder(
                    valueListenable: widget.selectedDates,
                    builder: (_, List<DateTime> dates, __) {
                      return Listener(
                        onPointerHover: dateRangeTapItem,
                        child: MonthList(
                          date,
                          widget.selectedDate,
                          widget.selectedDates,
                          config: widget.config,
                          key: key2,
                        ),
                      );
                    });
              }),
        );
      } else {
        return SizedBox(
          child: ValueListenableBuilder(
              valueListenable: widget.date,
              builder: (_, DateTime date, __) {
                return MonthList(
                  date,
                  widget.selectedDate,
                  widget.selectedDates,
                  config: widget.config,
                  key: key2,
                );
              }),
        );
      }
    } else {
      return SizedBox(
        child: ValueListenableBuilder(
            valueListenable: widget.date,
            builder: (_, DateTime date, __) {
              return MonthList(
                date,
                widget.selectedDate,
                widget.selectedDates,
                config: widget.config,
                key: key2,
              );
            }),
      );
    }
  }
}
