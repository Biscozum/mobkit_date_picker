import 'package:flutter/material.dart';

class MonthAndYearConfigModel {
  String? title;
  DateTime? minDate;
  DateTime? maxDate;
  bool showAllDays;
  bool disableOffDays;
  bool disableWeekendsDays;
  EdgeInsetsGeometry itemSpace;
  Duration animationDuration;
  Color enabledColor;
  Color disabledColor;
  Color selectedColor;
  Color isFirstLastItemColor;
  Color primaryColor;
  Color dividerColor;
  BorderRadiusGeometry borderRadius;
  TextStyle enableStyle;
  TextStyle disabledStyle;
  TextStyle currentStyle;
  MonthAndYearSelectionType selectionType;
  MonthAndYearConfigModel(
      {this.title,
      this.minDate,
      this.maxDate,
      this.showAllDays = true,
      this.disableOffDays = true,
      this.disableWeekendsDays = true,
      this.itemSpace = const EdgeInsets.all(2.0),
      this.animationDuration = const Duration(milliseconds: 300),
      this.enabledColor = Colors.transparent,
      this.disabledColor = const Color.fromARGB(255, 127, 127, 127),
      this.selectedColor = const Color.fromRGBO(253, 165, 46, 1),
      this.isFirstLastItemColor = const Color.fromARGB(255, 236, 10, 10),
      this.primaryColor = const Color.fromRGBO(253, 165, 46, 1),
      this.dividerColor = Colors.black,
      this.borderRadius = const BorderRadius.all(Radius.circular(4)),
      this.enableStyle = const TextStyle(fontWeight: FontWeight.bold),
      this.disabledStyle = const TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontWeight: FontWeight.bold),
      this.currentStyle = const TextStyle(color: Color.fromRGBO(253, 165, 46, 1), fontWeight: FontWeight.bold),
      this.selectionType = MonthAndYearSelectionType.selectionSingle});
}

enum MonthAndYearSelectionType { selectionScroll, selectionSingle, selectionRange }

// class StyleModel {
//   Duration animationDuration;
//   Color disabledColor;
//   Color selectedColor;
//   Color isFirstLastItemColor;
//   Color primaryColor;
//   Color dividerColor;
//   BorderRadiusGeometry borderRadius;
//   TextStyle? enableStyle;
//   TextStyle? disabledStyle;

//   StyleModel({
//     this.animationDuration = const Duration(milliseconds: 300),
//     this.disabledColor = const Color.fromARGB(255, 127, 127, 127),
//     this.selectedColor = const Color.fromRGBO(253, 165, 46, 1),
//     this.isFirstLastItemColor = const Color.fromARGB(255, 236, 10, 10),
//     this.primaryColor = const Color.fromRGBO(253, 165, 46, 1),
//     this.dividerColor = Colors.black,
//     this.borderRadius = const BorderRadius.all(Radius.circular(4)),
//     this.enableStyle = const TextStyle(fontWeight: FontWeight.bold),
//     this.disabledStyle = const TextStyle(color: Color.fromARGB(255, 127, 127, 127), fontWeight: FontWeight.bold),
//   });
// }
