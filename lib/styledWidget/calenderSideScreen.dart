import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/repository/eventdatasource.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/utils/utils.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:light/views/subviews/events/next_events.dart';
import 'package:light/views/subviews/events/upcoming_events.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderColumn extends ConsumerStatefulWidget {
  const CalenderColumn({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CalenderColumnState();
}

class _CalenderColumnState extends ConsumerState<CalenderColumn> {
  DateTime? dateTime;
  List<EventData> events = [];
  final eventsHiveData = Hive.box('events_box');
  @override
  void initState() {
    super.initState();
    ref.refresh(eventsProvider.notifier);
    events = refreshEvents(eventsHiveData)
        .map((e) =>
            EventData(date: e['date'], info: e['info'], title: e['title']))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(eventsProvider.notifier).assign(events);
  }

  @override
  Widget build(BuildContext context) {
    var calendarController = CalendarController();
    events = ref.watch(eventsProvider);
    return SizedBox(
      height: double.maxFinite,
      width: 300,
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 3.0,
          vertical: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: SfCalendar(
                            appointmentBuilder:
                                (context, calendarAppointmentDetails) =>
                                    const SizedBox(),
                            controller: calendarController,
                            timeRegionBuilder: (context, timeRegionDetails) =>
                                Container(),
                            monthCellBuilder: (context, details) => Center(
                                    child: Material(
                                  elevation: events.any((element) =>
                                          element.date == details.date)
                                      ? 0
                                      : 1,
                                  child: Material(
                                    shape: const CircleBorder(),
                                    child: CircleAvatar(
                                        foregroundColor: events.any((element) =>
                                                element.date == details.date)
                                            ? Theme.of(context).canvasColor
                                            : details.visibleDates.any(
                                                    (element) =>
                                                        element.month ==
                                                        details.date.month)
                                                ? Colors.black87
                                                : Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .color,
                                        backgroundColor: events.any((element) =>
                                                element.date == details.date)
                                            ? boldColors[details.date.day
                                                .remainder(boldColors.length)]
                                            : Colors.transparent,
                                        radius: 12,
                                        child: Text(
                                          details.date.day.toString(),
                                        )),
                                  ),
                                )),
                            allowAppointmentResize: true,
                            resourceViewHeaderBuilder: (context, details) =>
                                Container(),
                            onTap: (calendarTapDetails) => setState(() {
                                  dateTime = calendarTapDetails.date;
                                  createAnEvent(context, dateTime!);
                                }),
                            initialDisplayDate: DateTime.now(),
                            dataSource: getCalendarDataSource(ref),
                            cellBorderColor: Colors.transparent,
                            view: CalendarView.month,
                            onSelectionChanged: (calendarTapDetails) {
                              bool? isClicked = false;
                              setState(() {
                                dateTime = calendarTapDetails.date;
                              });
                            }),
                      ),
                    ),
                    Expanded(
                      child: UpcomingEventsTaB(
                          events: events,
                          ref: ref,
                          eventsHiveData: eventsHiveData),
                    ),
                    Expanded(
                      flex: 4,
                      child: NextEventsTab(
                          events: events,
                          ref: ref,
                          eventsHiveData: eventsHiveData),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
