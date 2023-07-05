// import 'package:flutter/material.dart';
// import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/calendar_date_bar.dart';
// import 'package:mobkit_date_picker/src/extensions/date_extensions.dart';
// import 'package:mobkit_date_picker/src/pickers/widgets/picker_header.dart';
// import '../../mobkit_date_picker.dart';
// import 'mobkit_calendar/calendar_month_selection_bar.dart';
// import 'mobkit_calendar/calendar_weekdays_bar.dart';
// import 'mobkit_calendar/calendar_year_selection_bar.dart';

// class MobkitCalendarOld extends StatelessWidget {
//   const MobkitCalendarOld({
//     Key? key,
//     required this.config,
//     required this.appointmentModel,
//     required this.calendarDate,
//     required this.selectedDate,
//     required this.onSelectionChange,
//   }) : super(key: key);
//   final MobkitCalendarConfigModel? config;
//   final List<MobkitCalendarAppointmentModel> appointmentModel;
//   final ValueNotifier<DateTime> selectedDate;
//   final ValueNotifier<DateTime> calendarDate;
//   final ValueChanged<List<MobkitCalendarAppointmentModel>> onSelectionChange;
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     return Column(
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         if (config?.title != null) Header(config!.title!),
//         const SizedBox(
//           height: 30,
//         ),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 10),
//           child: Row(
//             children: [
//               Expanded(flex: 8, child: CalendarMonthSelectionBar(calendarDate, config)),
//               const SizedBox(
//                 width: 10,
//               ),
//               Expanded(flex: 6, child: CalendarYearSelectionBar(calendarDate, config)),
//             ],
//           ),
//         ),
//         const SizedBox(
//           height: 25,
//         ),
//         CalendarWeekDaysBar(
//           config: config,
//           customCalendarModel: appointmentModel,
//         ),
//         const SizedBox(
//           height: 10,
//         ),
//         Container(
//             color: Colors.transparent,
//             child: DateSelectionBar(
//               calendarDate,
//               selectedDate,
//               onSelectionChange: onSelectionChange,
//               customCalendarModel: appointmentModel,
//               config: config,
//             )),
//         config?.mobkitCalendarViewType == MobkitCalendarViewType.daily
//             ? ValueListenableBuilder(
//                 valueListenable: selectedDate,
//                 builder: (_, DateTime date, __) {
//                   List<MobkitCalendarAppointmentModel> modelList = appointmentModel
//                       .where((element) =>
//                           (DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
//                                   .isBetween(element.appointmentStartDate, element.appointmentEndDate) ??
//                               false) ||
//                           DateTime(selectedDate.value.year, selectedDate.value.month, selectedDate.value.day)
//                               .isSameDay(element.appointmentStartDate))
//                       .toList();
//                   return Expanded(
//                     child: SingleChildScrollView(
//                       child: Stack(
//                         children: List<Widget>.generate(
//                           modelList.length,
//                           (i) {
//                             return Positioned(
//                               top: (80 *
//                                               (modelList[i].appointmentStartDate.hour +
//                                                   (modelList[i].appointmentStartDate.minute / 60)))
//                                           .toDouble() !=
//                                       0
//                                   ? (80 *
//                                               (modelList[i].appointmentStartDate.hour +
//                                                   (modelList[i].appointmentStartDate.minute / 60)))
//                                           .toDouble() +
//                                       9
//                                   : (80 *
//                                           (modelList[i].appointmentStartDate.hour +
//                                               (modelList[i].appointmentStartDate.minute / 60)))
//                                       .toDouble(),
//                               left: 58.5 + (modelList.length > 1 ? ((width * 0.8) / modelList.length) * i : 0),
//                               width: modelList.length > 1 ? (width * 0.8) / (modelList.length) : width * 0.8,
//                               height: modelList[i].appointmentEndDate.hour != 0
//                                   ? (((modelList[i]
//                                               .appointmentEndDate
//                                               .difference(modelList[i].appointmentStartDate)
//                                               .inMinutes) /
//                                           60) *
//                                       80)
//                                   : modelList[i]
//                                           .appointmentEndDate
//                                           .difference(modelList[i].appointmentStartDate)
//                                           .inHours *
//                                       80,
//                               child: Padding(
//                                 padding: const EdgeInsets.only(left: 1.5),
//                                 child: Container(
//                                   decoration: BoxDecoration(
//                                     color: modelList[i].color,
//                                     borderRadius: const BorderRadius.all(Radius.circular(1)),
//                                   ),
//                                   child: Align(
//                                     alignment: Alignment.topLeft,
//                                     child: Text(
//                                       modelList[i].title,
//                                       style: const TextStyle(color: Colors.white),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         )..insert(
//                             0,
//                             Column(
//                               children: List<Widget>.generate(
//                                 24,
//                                 (index) {
//                                   if (index == 0) {
//                                     return const SizedBox(
//                                       height: 80,
//                                     );
//                                   } else {
//                                     return Container(
//                                       alignment: Alignment.topCenter,
//                                       height: 80,
//                                       child: Padding(
//                                         padding: const EdgeInsets.only(left: 12, right: 12),
//                                         child: Row(
//                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                           crossAxisAlignment: CrossAxisAlignment.center,
//                                           children: [
//                                             Text(
//                                               "${(index).toString()}:00",
//                                               style: const TextStyle(color: Colors.black, fontSize: 18),
//                                             ),
//                                             Container(
//                                               width: width * 0.8,
//                                               color: Colors.grey,
//                                               height: 1,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     );
//                                   }
//                                 },
//                               ),
//                             ),
//                           ),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : Container(),
//       ],
//     );
//   }
// }
