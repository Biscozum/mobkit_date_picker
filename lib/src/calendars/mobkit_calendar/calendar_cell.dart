import 'package:flutter/material.dart';
import '../../../mobkit_date_picker.dart';

class CalendarCellWidget extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isEnabled;
  final bool isWeekDaysBar;
  final bool isCurrent;
  late final MobkitCalendarConfigModel configStandardCalendar;
  final List<MobkitCalendarAppointmentModel>? showedCustomCalendarModelList;
  CalendarCellWidget(
    this.text, {
    this.isSelected = false,
    this.isEnabled = true,
    this.isWeekDaysBar = false,
    this.isCurrent = false,
    MobkitCalendarConfigModel? standardCalendarConfig,
    this.showedCustomCalendarModelList,
    Key? key,
  }) : super(key: key) {
    if (standardCalendarConfig == null) {
      configStandardCalendar = MobkitCalendarConfigModel();
    } else {
      configStandardCalendar = standardCalendarConfig;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: configStandardCalendar.itemSpace,
      child: SizedBox(
        height: isWeekDaysBar ? 40 : 60,
        width: MediaQuery.of(context).size.width * 0.12,
        child: AnimatedContainer(
          duration: configStandardCalendar.animationDuration,
          decoration: BoxDecoration(
            color: isEnabled
                ? isSelected
                    ? configStandardCalendar.selectedColor.withOpacity(1.0)
                    : configStandardCalendar.enabledColor
                : configStandardCalendar.disabledColor,
            border: isWeekDaysBar
                ? Border.all(width: 1, color: configStandardCalendar.weekDaysBarBorderColor)
                : Border.all(
                    width: configStandardCalendar.borderWidth,
                    color: isSelected
                        ? configStandardCalendar.selectedBorderColor
                        : configStandardCalendar.enabledBorderColor),
            borderRadius: configStandardCalendar.borderRadius,
          ),
          child: isWeekDaysBar
              ? Center(
                  child: Text(
                    text,
                    style: isEnabled
                        ? isCurrent
                            ? isSelected
                                ? configStandardCalendar.selectedStyle
                                : configStandardCalendar.currentStyle
                            : isSelected
                                ? configStandardCalendar.selectedStyle
                                : configStandardCalendar.monthDaysStyle
                        : configStandardCalendar.disabledStyle,
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Spacer(),
                          Text(
                            text,
                            style: isEnabled
                                ? isCurrent
                                    ? isSelected
                                        ? configStandardCalendar.selectedStyle
                                        : configStandardCalendar.currentStyle
                                    : isSelected
                                        ? configStandardCalendar.selectedStyle
                                        : configStandardCalendar.monthDaysStyle
                                : configStandardCalendar.disabledStyle,
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: generateItems(showedCustomCalendarModelList),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: generateAllDayItems(showedCustomCalendarModelList, context),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  List<Widget> generateItems(List<MobkitCalendarAppointmentModel>? showedCustomCalendarModelList) {
    List<Widget> items = [];
    if (showedCustomCalendarModelList != null) {
      List<MobkitCalendarAppointmentModel> listModel =
          showedCustomCalendarModelList.where((element) => !element.isAllDay).toList();
      if (listModel.isNotEmpty) {
        for (int i = 0; listModel.length > 3 ? i < 3 : i < listModel.length; i++) {
          items.add(
            Padding(
              padding: const EdgeInsets.all(1),
              child: CircleAvatar(
                radius: 5,
                backgroundColor: listModel[i].color,
              ),
            ),
          );
        }
      }
    }
    return items;
  }

  List<Widget> generateAllDayItems(
      List<MobkitCalendarAppointmentModel>? showedCustomCalendarModelList, BuildContext context) {
    List<Widget> items = [];
    if (showedCustomCalendarModelList != null && showedCustomCalendarModelList.isNotEmpty) {
      List<MobkitCalendarAppointmentModel> listModel =
          showedCustomCalendarModelList.where((element) => element.isAllDay).toList();
      if (listModel.isNotEmpty) {
        for (int i = 0; i < listModel.length; i++) {
          items.add(
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(2.0)),
                color: listModel[i].color,
              ),
              height: 3.3,
            ),
          );
        }
      }
    }
    return items;
  }
}
