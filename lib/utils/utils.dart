import 'package:flutter/material.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/utils/savedatedialog.dart';

void createAnEvent(BuildContext context, EventData markedDateTitle) {
  showDialog(
    context: context,
    builder: (context) => SaveDateDialog(eventdata: markedDateTitle),
  );
}
