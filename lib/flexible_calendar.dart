library flexible_calendar;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FlexibleCalendarView extends StatefulWidget {
  const FlexibleCalendarView(
      {Key? key,
      this.initialStartDate,
      this.initialEndDate,
      this.startEndDateChange,
      this.maximumDate,
      this.minimumDate,
      this.formatMonthTitle,
      this.textPreMonthTitle,
      this.isConvertDateOfWeekToVietnamese,
      this.formatTitleDateOfWeek,
      this.colorDayInAnotherMonth,
      this.colorOfSelectedDay,
      this.colorOfDayInMonth,
      this.styleOfDay,
      this.decorationOfSelectedDay,
      this.isSelectedOnlyOneDay,
      this.colorInRange,
      this.borderBackgroundStartDay,
      this.borderBackgroundEndDay})
      : super(key: key);

  final DateTime? minimumDate;
  final DateTime? maximumDate;
  final DateTime? initialStartDate;
  final DateTime? initialEndDate;
  final DateFormat? formatMonthTitle;
  final String? textPreMonthTitle;
  final bool? isConvertDateOfWeekToVietnamese;
  final String? formatTitleDateOfWeek;
  final Color? colorDayInAnotherMonth;
  final Color? colorOfSelectedDay;
  final Color? colorOfDayInMonth;
  final TextStyle? styleOfDay;
  final BoxDecoration? decorationOfSelectedDay;
  final bool? isSelectedOnlyOneDay;
  final Color? colorInRange;
  final BorderRadius? borderBackgroundStartDay;
  final BorderRadius? borderBackgroundEndDay;

  final Function(DateTime, DateTime?)? startEndDateChange;

  @override
  _FlexibleCalendarViewState createState() => _FlexibleCalendarViewState();
}

class _FlexibleCalendarViewState extends State<FlexibleCalendarView> {
  List<DateTime> dateList = <DateTime>[];
  DateTime? currentMonthDate = DateTime.now();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    if (widget.initialStartDate != null) {
      currentMonthDate = widget.initialStartDate;
    }
    setListOfDate(currentMonthDate);
    if (widget.initialStartDate != null) {
      startDate = widget.initialStartDate;
    }
    if (widget.initialEndDate != null) {
      endDate = widget.initialEndDate;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setListOfDate(DateTime? monthDate) {
    dateList.clear();
    final DateTime newDate = DateTime(monthDate!.year, monthDate.month, 0);
    int previousMothDay = 0;
    if (newDate.weekday < 7) {
      previousMothDay = newDate.weekday;
      for (int i = 1; i <= previousMothDay; i++) {
        dateList.add(newDate.subtract(Duration(days: previousMothDay - i)));
      }
    }
    for (int i = 0; i < (42 - previousMothDay); i++) {
      dateList.add(newDate.add(Duration(days: i + 1)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 4, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate!.year, currentMonthDate!.month, 0);
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_left,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    "${widget.textPreMonthTitle != null ? widget.textPreMonthTitle : "Tháng"} ${(widget.formatMonthTitle != null ? widget.formatMonthTitle : DateFormat('M, yyyy'))!.format(currentMonthDate!)}",
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 38,
                    width: 38,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {
                          setState(() {
                            currentMonthDate = DateTime(currentMonthDate!.year, currentMonthDate!.month + 2, 0);
                            setListOfDate(currentMonthDate);
                          });
                        },
                        child: Icon(
                          Icons.keyboard_arrow_right,
                          color: Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8, bottom: 8),
            child: Row(
              children: getDaysNameUI(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8, left: 8),
            child: Column(
              children: getDaysNoUI(),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getDaysNameUI() {
    final List<Widget> listUI = <Widget>[];
    for (int i = 0; i < 7; i++) {
      listUI.add(
        Expanded(
          child: Center(
            child: Text(
              widget.isConvertDateOfWeekToVietnamese == true
                  ? convertDateOfWeekToVietnamese(
                      DateFormat(widget.formatTitleDateOfWeek != null ? widget.formatTitleDateOfWeek : 'EEE').format(dateList[i].toLocal()))
                  : DateFormat(widget.formatTitleDateOfWeek != null ? widget.formatTitleDateOfWeek : 'EEE').format(dateList[i].toLocal()),
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF797E88),
              ),
            ),
          ),
        ),
      );
    }
    return listUI;
  }

  String convertDateOfWeekToVietnamese(String dayOfWeek) {
    switch (dayOfWeek.toUpperCase()) {
      case "MON":
        return "T2";
      case "TUE":
        return "T3";
      case "WED":
        return "T4";
      case "THU":
        return "T5";
      case "FRI":
        return "T6";
      case "SAT":
        return "T7";
      default:
        return "CN";
    }
  }

  List<Widget> getDaysNoUI() {
    final List<Widget> noList = <Widget>[];
    int count = 0;
    for (int i = 0; i < dateList.length / 7; i++) {
      final List<Widget> listUI = <Widget>[];
      for (int i = 0; i < 7; i++) {
        final DateTime date = dateList[count];
        listUI.add(
          Expanded(
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 4),
                      child: Material(
                        color: Colors.transparent,
                        child: Padding(
                          padding: EdgeInsets.only(top: 2, bottom: 2, left: isStartDateRadius(date) ? 4 : 0, right: isEndDateRadius(date) ? 4 : 0),
                          child: Container(
                            decoration: BoxDecoration(
                                color: startDate != null && endDate != null
                                    ? getIsItStartAndEndDate(date) || getIsInRange(date)
                                        ? widget.colorInRange ?? Color(0xFFE3ECFF)
                                        : Colors.transparent
                                    : Colors.transparent,
                                borderRadius: isStartDateRadius(date)
                                    ? widget.borderBackgroundStartDay ??
                                        BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))
                                    : isEndDateRadius(date)
                                        ? widget.borderBackgroundEndDay ??
                                            BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25))
                                        : BorderRadius.circular(0)),
                          ),
                        ),
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: const BorderRadius.all(Radius.circular(32.0)),
                        onTap: () {
                          if (widget.minimumDate != null) {
                            final DateTime newminimumDate =
                                DateTime(widget.minimumDate!.year, widget.minimumDate!.month, widget.minimumDate!.day - 1);
                            if (date.isAfter(newminimumDate)) {
                              onDateClick(date);
                            }
                          } else if (widget.maximumDate != null) {
                            final DateTime newmaximumDate = DateTime(widget.maximumDate?.year ?? DateTime.now().year,
                                widget.maximumDate?.month ?? DateTime.now().month, (widget.maximumDate?.day ?? DateTime.now().day) + 1);
                            if (date.isBefore(newmaximumDate)) {
                              onDateClick(date);
                            }
                          } else {
                            onDateClick(date);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: Container(
                            decoration: getIsItStartAndEndDate(date)
                                ? widget.decorationOfSelectedDay ??
                                    BoxDecoration(
                                        color: Color(0xFF3874EF),
                                        borderRadius: const BorderRadius.all(Radius.circular(6)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(color: Colors.grey.withOpacity(0.6), blurRadius: 4, offset: const Offset(0, 0)),
                                        ])
                                : BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                            child: Center(
                              child: Text(
                                '${date.day}',
                                style:
                                    (widget.styleOfDay != null ? widget.styleOfDay : TextStyle(fontSize: 15, fontWeight: FontWeight.w500))!.copyWith(
                                  color: getIsItStartAndEndDate(date)
                                      ? widget.colorOfSelectedDay ?? Colors.white
                                      : currentMonthDate!.month == date.month
                                          ? widget.colorOfDayInMonth ?? Colors.black
                                          : widget.colorDayInAnotherMonth ?? Color(0xFF797E88),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 9,
                      right: 0,
                      left: 0,
                      child: Container(
                        height: 6,
                        width: 6,
                        decoration: BoxDecoration(
                            color: DateTime.now().day == date.day && DateTime.now().month == date.month && DateTime.now().year == date.year
                                ? getIsInRange(date)
                                    ? Colors.white
                                    : Colors.blue
                                : Colors.transparent,
                            shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        count += 1;
      }
      noList.add(Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: listUI,
      ));
    }
    return noList;
  }

  bool getIsInRange(DateTime date) {
    if (startDate != null && endDate != null) {
      if (date.isAfter(startDate!) && date.isBefore(endDate!)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool getIsItStartAndEndDate(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month && startDate!.year == date.year) {
      return true;
    } else if (endDate != null && endDate!.day == date.day && endDate!.month == date.month && endDate!.year == date.year) {
      return true;
    } else {
      return false;
    }
  }

  bool isStartDateRadius(DateTime date) {
    if (startDate != null && startDate!.day == date.day && startDate!.month == date.month) {
      return true;
    } else if (date.weekday == 1) {
      return true;
    } else {
      return false;
    }
  }

  bool isEndDateRadius(DateTime date) {
    if (endDate != null && endDate!.day == date.day && endDate!.month == date.month) {
      return true;
    } else if (date.weekday == 7) {
      return true;
    } else {
      return false;
    }
  }

  void onDateClick(DateTime date) {
    if (widget.isSelectedOnlyOneDay == true) {
      startDate = date;
      endDate = null;
      setState(() {
        try {
          widget.startEndDateChange!(startDate!, endDate);
        } catch (_) {}
      });
    } else {
      if (startDate != null && endDate == null && date.isAfter(startDate!)) {
        endDate = date;
      } else {
        startDate = date;
        endDate = null;
      }
      setState(() {
        try {
          widget.startEndDateChange!(startDate!, endDate);
        } catch (_) {}
      });
    }
  }
}
