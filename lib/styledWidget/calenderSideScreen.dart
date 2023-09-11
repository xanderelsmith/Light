import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:light/utils/constants.dart';
import 'package:light/utils/savedatedialog.dart';
import 'package:light/utils/utils.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/calendermodels/event_data_model.dart';

class CalenderColumn extends StatefulWidget {
  CalenderColumn({
    Key? key,
  }) : super(key: key);
  @override
  State<CalenderColumn> createState() => _CalenderColumnState();
}

DateTime? dateTime;

class _CalenderColumnState extends State<CalenderColumn> {
  @override
  Widget build(BuildContext context) {
    EventData? markedDateTitle;
    var dateTimenow = DateTime.now();
    return Card(
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
                children: [
                  Expanded(
                    flex: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: CalendarDatePicker(
                        selectableDayPredicate: (day) => !day.isUtc,
                        firstDate:
                            DateTime.parse("${dateTimenow.year - 10}-12-24"),
                        currentDate: dateTimenow,
                        lastDate:
                            DateTime.parse("${dateTimenow.year + 10}-12-24"),
                        onDateChanged: (day) {
                          setState(() {
                            dateTime = day;
                            createAnEvent(context, markedDateTitle!);
                          });
                        },
                        initialDate: DateTime.now(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Upcoming Event',
                              style: Constants.defaultTextStyle,
                            ),
                            Expanded(
                                child: Center(
                              child: Row(children: [
                                SizedBox(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Card(
                                    color: Colors.deepPurple,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text('07',
                                          style: Constants.defaultTextStyle
                                              .copyWith(fontSize: 20)),
                                    ),
                                  ),
                                )),
                                Expanded(
                                  child: SizedBox(
                                      width: double.maxFinite,
                                      child: Card(
                                        color: Theme.of(context).canvasColor,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('Preparation for Exams',
                                              softWrap: true,
                                              maxLines: 1,
                                              style: Constants.defaultTextStyle
                                                  .copyWith(fontSize: 20)),
                                        ),
                                      )),
                                )
                              ]),
                            ))
                          ]),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: [
                        Divider(color: Colors.brown, height: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Today', textAlign: TextAlign.left),
                              Expanded(
                                child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ListTile()),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: Colors.brown, height: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('This Term', textAlign: TextAlign.left),
                              Expanded(
                                child: ListView.builder(
                                    itemBuilder: (context, index) =>
                                        ListTile()),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
