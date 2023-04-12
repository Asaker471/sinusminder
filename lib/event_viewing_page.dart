import 'package:calendar_app/event_editing_page.dart';
import 'package:calendar_app/event_provider.dart';
import 'event.dart';
import 'utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'tasks_widget.dart';

class EventViewingPage extends StatelessWidget {
  final Event event;

  const EventViewingPage({
    Key? key,
    required this.event,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          leading: CloseButton(),
          actions: buildViewingActions(context, event),
        ),
        body: ListView(
          padding: EdgeInsets.all(32),
          children: <Widget>[
            buildDateTime(event),
            SizedBox(height: 32),
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Text(
              event.description,
              style: TextStyle(color: Colors.white, fontSize: 18),
            )
          ],
        ),
      );

  Widget buildDateTime(Event event) {
    return Column(
      children: [
        buildDate(event.isAllDay ? 'All-day' : 'From', event.from),
        if (!event.isAllDay) buildDate('To', event.to),
      ],
    );
  }
}

Widget buildDate(String title, DateTime date) {
  return Row(
    children: [
      Text(
        title + ': ',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      Text(date.toString()),
    ],
  );
}

List<Widget> buildViewingActions(BuildContext context, Event event) {
  return [
    IconButton(
      icon: Icon(Icons.edit),
      onPressed: () => Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => EventEditingPage(event: event),
        ),
      ),
    ),
    IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          final provider = Provider.of<EventProvider>(context, listen: false);

          Navigator.of(context).pop();
        }),
  ];
}
