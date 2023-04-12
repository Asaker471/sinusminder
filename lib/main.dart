// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';

// void main() {
//   runApp(
//     MaterialApp(
//       home: MyAppointmentScheduler(),
//     ),
//   );
// }

// class MyAppointmentScheduler extends StatefulWidget {
//   @override
//   _MyAppointmentSchedulerState createState() => _MyAppointmentSchedulerState();
// }

// class _MyAppointmentSchedulerState extends State<MyAppointmentScheduler> {
//   CalendarFormat _calendarFormat = CalendarFormat.month;
//   DateTime _selectedDate = DateTime.now();
//   late DateTimeRange _selectedDateRange;
//   Map<DateTime, List<dynamic>> _events = {};
//   List<dynamic> _selectedEvents = [];

//   void _onDaySelected(DateTime selectedDate, List<dynamic> events) {
//     setState(() {
//       _selectedDate = selectedDate;
//       _selectedEvents = events;
//     });
//   }

//   void _onDateRangeSelected(DateTimeRange dateRange) {
//     setState(() {
//       _selectedDateRange = dateRange;
//     });
//   }

//   void _addEvent() {
//     if (_selectedDateRange == null) {
//       List<dynamic> events = _events[_selectedDate] ?? [];
//       events.add('New Appointment');
//       _events[_selectedDate] = events;
//     } else {
//       for (var i = _selectedDateRange.start;
//           i.isBefore(_selectedDateRange.end);
//           i = i.add(Duration(days: 1))) {
//         List<dynamic> events = _events[i] ?? [];
//         events.add('New Appointment');
//         _events[i] = events;
//       }
//     }
//     _selectedEvents = _events[_selectedDate] ?? [];
//   }

//   void _attendEvent(dynamic event) {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text("Did you attend the appointment?"),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//               _selectedEvents.remove(event);
//               setState(() {});
//             },
//             child: Text("Yes"),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: Text("No"),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         home: Scaffold(
//             appBar: AppBar(
//               title: Text("SinusMinder Calendar"),
//             ),
//             body:
//                 Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               TableCalendar(
//                 calendarFormat: _calendarFormat,
//                 onFormatChanged: (format) {
//                   setState(() {
//                     _calendarFormat = format;
//                   });
//                 },
//                 calendarBuilders: CalendarBuilders(
//                   selectedBuilder: (context, date, events) => Container(
//                     decoration: BoxDecoration(
//                       color: Theme.of(context).primaryColor,
//                       shape: BoxShape.circle,
//                     ),
//                     margin: const EdgeInsets.all(4.0),
//                     alignment: Alignment.center,
//                     child: Text(
//                       date.day.toString(),
//                       style: TextStyle(color: Color.fromARGB(255, 246, 27, 27)),
//                     ),
//                   ),
//                 ),
//                 focusedDay: _selectedDate,
//                 firstDay: DateTime.utc(2021, 1, 1),
//                 lastDay: DateTime.utc(2024, 12, 31),
//               )
//             ])));
//   }
// }

import 'package:calendar_app/calendarwidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:provider/provider.dart';
import 'event_editing_page.dart';

void main() {
  runApp(MyAppointmentScheduler());
}

class MyAppointmentScheduler extends StatelessWidget {
  static String title = 'SinusMinder';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark(),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.red,
      ),
      home: MyAppointmentSchedulerHomePage(),
    );
  }
}

class MyAppointmentSchedulerHomePage extends StatelessWidget {
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(MyAppointmentScheduler.title),
          centerTitle: true,
        ),
        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.red,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage()),
          ),
        ),
      );
}
