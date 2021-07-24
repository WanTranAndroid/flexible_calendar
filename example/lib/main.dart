import 'package:flexible_calendar/flexible_calendar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? timeChecking;
  DateTime? timeCheckout;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showDialogCalendar(context);
        },
      ),
    );
  }

  _showDialogCalendar(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topRight: Radius.circular(15), topLeft: Radius.circular(15)),
        ),
        builder: (context) {
          return GestureDetector(
            onVerticalDragDown: (_) {},
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                child:
                    FlexibleCalendarView(
                      //limit start date
                      // minimumDate: isChecking || timeChecking == null ? DateTime.now() : timeChecking?.add(Duration(days: 1)),
                      //limit end date
                      // maximumDate: isChecking || timeChecking == null ? DateTime.now() : timeChecking?.add(Duration(days: 1)),
                      initialStartDate: timeChecking,
                      initialEndDate: timeCheckout,
                      startEndDateChange: (DateTime startDateData, DateTime? endDateData) {
                        setState(() {
                          timeChecking = startDateData;
                          timeCheckout = endDateData;
                        });
                      },
                      isConvertDateOfWeekToVietnamese: true,
                      formatMonthTitle: DateFormat("MM, yyyy"),
                      textPreMonthTitle: "Tháng",
                      decorationOfSelectedDay: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(25)
                      ),
                      colorDayInAnotherMonth: Colors.grey,
                      colorInRange: Colors.blue.withOpacity(0.1),
                      borderBackgroundStartDay: BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25)),
                      borderBackgroundEndDay: BorderRadius.only(topRight: Radius.circular(25), bottomRight: Radius.circular(25)),
                      formatTitleDateOfWeek: "EEE",
                      isSelectedOnlyOneDay: false,
                      colorOfDayInMonth: Colors.black,
                      colorOfSelectedDay: Colors.white,
                      styleOfDay: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          );
        });
  }
}
