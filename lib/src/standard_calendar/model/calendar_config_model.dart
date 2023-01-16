import 'package:flutter/material.dart';

class CalendarConfigModel {
  String? title;
  bool showAllDays;
  bool disableOffDays;
  bool disableWeekendsDays;
  int firstDayIs;
  SelectionType dateSelectType;
  PickerType pickerType = PickerType.standard;
  DateTime? disableBefore;
  DateTime? disableAfter;
  List<DateTime>? disabledDates;
  TextStyle? dateStyle;
  EdgeInsetsGeometry itemSpace;
  Duration animationDuration;
  Color enabledColor;
  Color disabledColor;
  Color selectedColor;
  Color isFirstLastItemColor;
  Color primaryColor;
  Color enabledBorderColor;
  Color disabledBorderColor;
  Color selectedBorderColor;
  double borderWidth;
  BorderRadiusGeometry borderRadius;
  TextStyle enableStyle;
  TextStyle monthDaysStyle;
  TextStyle weekDaysStyle;
  TextStyle disabledStyle;
  TextStyle currentStyle;
  TextStyle selectedStyle;
  CalendarConfigModel(
      {this.title,
      this.showAllDays = true,
      this.disableOffDays = true,
      this.disableWeekendsDays = true,
      this.firstDayIs = DateTime.wednesday,
      this.dateSelectType = SelectionType.singleTap,
      this.disableBefore,
      this.disableAfter,
      this.disabledDates,
      this.dateStyle,
      this.itemSpace = const EdgeInsets.all(2.0),
      this.animationDuration = const Duration(milliseconds: 300),
      this.enabledColor = Colors.transparent,
      this.disabledColor = const Color.fromARGB(255, 127, 127, 127),
      this.selectedColor = const Color.fromRGBO(253, 165, 46, 1),
      this.isFirstLastItemColor = const Color.fromARGB(255, 236, 10, 10),
      this.primaryColor = const Color.fromRGBO(253, 165, 46, 1),
      this.enabledBorderColor = Colors.transparent,
      this.disabledBorderColor = const Color.fromARGB(255, 127, 127, 127),
      this.selectedBorderColor = Colors.black,
      this.borderWidth = 1,
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.enableStyle = const TextStyle(fontWeight: FontWeight.bold),
      this.monthDaysStyle = const TextStyle(fontWeight: FontWeight.normal),
      this.weekDaysStyle = const TextStyle(color: Color.fromRGBO(253, 165, 46, 1), fontWeight: FontWeight.bold),
      this.disabledStyle = const TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontWeight: FontWeight.bold),
      this.currentStyle = const TextStyle(color: Color.fromRGBO(253, 165, 46, 1), fontWeight: FontWeight.bold),
      this.selectedStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)});
}

enum SelectionType { rangeTap, singleTap }

enum PickerType { day, month, monthAndYear, standard }

// class DateCellStyleModel {
//   Duration animationDuration;
//   Color enabledColor;
//   Color disabledColor;
//   Color selectedColor;
//   Color isFirstLastItemColor;
//   Color primaryColor;
//   Color enabledBorderColor;
//   Color disabledBorderColor;
//   Color selectedBorderColor;
//   double borderWidth;
//   BorderRadiusGeometry borderRadius;
//   TextStyle enableStyle;
//   TextStyle monthDaysStyle;
//   TextStyle weekDaysStyle;
//   TextStyle disabledStyle;
//   TextStyle selectedStyle;

//   DateCellStyleModel(
//       {this.animationDuration = const Duration(milliseconds: 300),
//       this.enabledColor = Colors.transparent,
//       this.disabledColor = const Color.fromARGB(255, 127, 127, 127),
//       this.selectedColor = const Color.fromRGBO(253, 165, 46, 1),
//       this.isFirstLastItemColor = const Color.fromARGB(255, 236, 10, 10),
//       this.primaryColor = const Color.fromRGBO(253, 165, 46, 1),
//       this.enabledBorderColor = Colors.transparent,
//       this.disabledBorderColor = const Color.fromARGB(255, 127, 127, 127),
//       this.selectedBorderColor = Colors.black,
//       this.borderWidth = 1,
//       this.borderRadius = const BorderRadius.all(Radius.circular(4)),
//       this.enableStyle = const TextStyle(fontWeight: FontWeight.bold),
//       this.monthDaysStyle = const TextStyle(fontWeight: FontWeight.normal),
//       this.weekDaysStyle = const TextStyle(color: Color.fromRGBO(253, 165, 46, 1), fontWeight: FontWeight.bold),
//       this.disabledStyle = const TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontWeight: FontWeight.bold),
//       this.selectedStyle = const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)});
// }
