import 'package:flutter/material.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/models/datasource.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

DataSource getCalendarDataSource(ref) {
  final eventProviderData = ref.watch(eventsProvider);
  List<Appointment> appointments = <Appointment>[];
  eventProviderData.forEach((EventData element) {
    var subject2 = 'Meeting';
    appointments.add(Appointment(
      startTime: element.date,
      endTime: element.date.add(
        const Duration(hours: 2),
      ),
      isAllDay: true,
      subject: subject2,
      startTimeZone: '',
      color: Colors.transparent,
      endTimeZone: '',
    ));
  });

  return DataSource(appointments);
}
