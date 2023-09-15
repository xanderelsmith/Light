import 'dart:math';

import 'package:flutter/material.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/utils/utils.dart';
import 'package:light/views/subviews/edit_event_screen.dart';

import '../utils/constants.dart';

class EventTileWidget extends StatelessWidget {
  EventTileWidget({
    super.key,
    required this.eventdata,
    required this.onDelete,
    this.onTap,
  });
  final EventData eventdata;
  final VoidCallback onDelete;
  final VoidCallback? onTap;
  final nextInt = Random().nextInt(16);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(children: [
        SizedBox(
            child: Align(
          alignment: Alignment.center,
          child: Card(
            color: boldColors[eventdata.date.day.remainder(boldColors.length)],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                eventdata.date.day.toString() ?? '',
                style: Constants.defaultTextStyle
                    .copyWith(fontSize: 20, color: Colors.black),
              ),
            ),
          ),
        )),
        Expanded(
          child: SizedBox(
            width: double.maxFinite,
            child: Card(
              color: Theme.of(context).canvasColor,
              child: InkWell(
                onTap: () {
                  onTap!();
                  showDialog(
                    context: context,
                    builder: (context) => const EditEventScreen(),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(eventdata.title.toString(),
                      softWrap: true,
                      maxLines: 1,
                      style: Constants.defaultTextStyle.copyWith(
                        color: Colors.black,
                        fontSize: 20,
                      )),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
            child: Align(
          alignment: Alignment.center,
          child: Card(
            shape: const CircleBorder(
              side: BorderSide(color: Colors.red, width: 5),
            ),
            child: IconButton(
              onPressed: () {
                onDelete();
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        )),
      ]),
    );
  }
}
