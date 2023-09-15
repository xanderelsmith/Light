import "package:flutter/material.dart";
import "package:light/models/calendermodels/event_data_model.dart";
import "package:light/utils/savedatedialog.dart";

void createAnEvent(BuildContext context, DateTime dateTime) {
  showDialog(
    context: context,
    builder: (context) {
      return SaveDateDialog(datetime: dateTime);
    },
  );
}

const List boldColors = [
  Colors.red,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.lightBlue,
  Colors.green,
  Colors.purple,
  Colors.deepPurple,
  Colors.indigo,
  Colors.lightGreen,
  Colors.lime,
  Colors.orange,
  Colors.grey,
  Colors.blueGrey,
];

void dateSorter(List<EventData> data) {
  data.sort((a, b) {
    return a.date.day.compareTo(b.date.day);
  });
  data.sort((a, b) {
    return a.date.month.compareTo(b.date.month);
  });
  data.sort((a, b) {
    return a.date.year.compareTo(b.date.year);
  });
}
