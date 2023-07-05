import 'package:flutter/material.dart';
import 'package:mobkit_date_picker/src/calendars/mobkit_calendar/model/recurrence_model.dart';

class MobkitCalendarAppointmentModel {
  int? index;
  String title;
  DateTime appointmentStartDate;
  DateTime appointmentEndDate;
  Color color;
  bool isAllDay;
  String detail;
  RecurrenceModel? recurrenceModel;
  MobkitCalendarAppointmentModel({
    required this.title,
    required this.appointmentStartDate,
    required this.appointmentEndDate,
    required this.color,
    required this.isAllDay,
    required this.detail,
    required this.recurrenceModel,
  });
}
