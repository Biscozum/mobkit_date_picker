import 'package:flutter/material.dart';
import '../../mobkit_date_picker.dart';
import '../model/calendar_type_model.dart';

class CellWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final bool isFirstSelectedItem;
  final bool isLastSelectedItem;
  final bool isWeekDaysBar;
  final bool isCurrent;
  final CalendarType calendarType;
  late final StandardCalendarConfigModel configStandardCalendar;
  late final MonthAndYearConfigModel configMonthAndYear;
  CellWidget(
    this.text, {
    this.isSelected = false,
    this.isEnabled = true,
    this.isFirstSelectedItem = false,
    this.isLastSelectedItem = false,
    this.isWeekDaysBar = false,
    this.isCurrent = false,
    this.calendarType = CalendarType.standardCalendar,
    StandardCalendarConfigModel? standardCalendarConfig,
    MonthAndYearConfigModel? monthAndYearConfig,
    Key? key,
  }) : super(key: key) {
    if (standardCalendarConfig == null) {
      configStandardCalendar = StandardCalendarConfigModel();
    } else {
      configStandardCalendar = standardCalendarConfig;
    }
    if (monthAndYearConfig == null) {
      configMonthAndYear = MonthAndYearConfigModel();
    } else {
      configMonthAndYear = monthAndYearConfig;
    }
  }
  @override
  Widget build(BuildContext context) {
    if (calendarType == CalendarType.monthAndYearCalendar) {
      return Padding(
        padding: configMonthAndYear.itemSpace,
        child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.12,
          child: AnimatedContainer(
            duration: configMonthAndYear.animationDuration,
            decoration: BoxDecoration(
                color: isFirstSelectedItem || isLastSelectedItem
                    ? configMonthAndYear.selectedColor
                    : isSelected
                        ? configMonthAndYear.selectedColor.withOpacity(
                            configMonthAndYear.selectionType == MonthAndYearSelectionType.selectionRange ? 0.70 : 1.0)
                        : configMonthAndYear.enabledColor,
                border: isWeekDaysBar ? Border.all(width: 1, color: configMonthAndYear.primaryColor) : null,
                borderRadius: configMonthAndYear.borderRadius),
            child: Center(
              child: Text(
                text,
                style: isEnabled
                    ? isSelected
                        ? configStandardCalendar.selectedStyle
                        : configStandardCalendar.monthDaysStyle
                    : configStandardCalendar.disabledStyle,
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: configStandardCalendar.itemSpace,
        child: SizedBox(
          height: 40,
          width: MediaQuery.of(context).size.width * 0.12,
          child: AnimatedContainer(
            duration: configStandardCalendar.animationDuration,
            decoration: BoxDecoration(
                color: isEnabled
                    ? isFirstSelectedItem || isLastSelectedItem
                        ? configStandardCalendar.selectedColor
                        : isSelected
                            ? configStandardCalendar.selectedColor.withOpacity(
                                configStandardCalendar.selectionType == SelectionType.rangeTap ? 0.70 : 1.0)
                            : configStandardCalendar.enabledColor
                    : configStandardCalendar.disabledColor,
                border: isWeekDaysBar
                    ? Border.all(width: configStandardCalendar.borderWidth, color: configStandardCalendar.primaryColor)
                    : null,
                borderRadius: configStandardCalendar.borderRadius),
            child: Center(
              child: Text(
                text,
                style: isEnabled
                    ? isCurrent
                        ? isSelected
                            ? configStandardCalendar.selectedStyle
                            : configMonthAndYear.currentStyle
                        : isSelected
                            ? configStandardCalendar.selectedStyle
                            : configStandardCalendar.monthDaysStyle
                    : configStandardCalendar.disabledStyle,
              ),
            ),
          ),
        ),
      );
    }
    // return Padding(
    //   padding: config.itemSpace,
    //   child: SizedBox(
    //     height: 40,
    //     width: MediaQuery.of(context).size.width * 0.12,
    //     child: AnimatedContainer(
    //       duration: config.cellStyle.animationDuration,
    //       decoration: BoxDecoration(
    //           color: isEnabled
    //               ? isFirstSelectedItem || isLastSelectedItem
    //                   ? config.cellStyle.selectedColor
    //                   : isSelected
    //                       ? config.cellStyle.selectedColor.withOpacity(
    //                           config.dateSelectType == SelectionType.rangeTap ||
    //                                   config.dateSelectType == SelectionType.rangeSwipe
    //                               ? 0.70
    //                               : 1.0)
    //                       : config.cellStyle.enabledColor
    //               : config.cellStyle.disabledColor,
    //           border: Border.all(
    //               width: config.cellStyle.borderWidth,
    //               color: isEnabled
    //                   ? isSelected
    //                       ? config.cellStyle.selectedBorderColor.withOpacity(0.70)
    //                       : config.cellStyle.enabledBorderColor
    //                   : config.cellStyle.disabledBorderColor),
    //           borderRadius: config.cellStyle.borderRadius),
    //       child: Center(
    //         child: Text(
    //           text,
    //           style: isEnabled
    //               ? isSelected
    //                   ? config.cellStyle.selectedStyle
    //                   : config.cellStyle.enableStyle
    //               : config.cellStyle.disabledStyle,
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
