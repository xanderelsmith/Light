import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/utils/constants.dart';
import 'package:light/models/calendermodels/event_data_model.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:light/utils/utils.dart';
import 'package:intl/intl.dart';

class SaveDateDialog extends ConsumerStatefulWidget {
  const SaveDateDialog({super.key, required this.datetime});
  final DateTime datetime;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SaveDateDialogState();
}

class _SaveDateDialogState extends ConsumerState<SaveDateDialog> {
  late EventData eventdata;
  @override
  void initState() {
    super.initState();
    eventdata = EventData.initial;
  }

  @override
  Widget build(BuildContext context) {
    final eventsHiveData = Hive.box('events_box');
    final eventsProviderData = ref.watch(eventsProvider);
    return Dialog(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 200,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(children: [
                SizedBox(
                    child: Align(
                  alignment: Alignment.center,
                  child: Card(
                    color: Colors.deepPurple,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(DateFormat.E().format(widget.datetime),
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
                          child: Text(
                              DateFormat.yMMMd().format(widget.datetime),
                              softWrap: true,
                              maxLines: 1,
                              style: Constants.defaultTextStyle
                                  .copyWith(fontSize: 20)),
                        ),
                      )),
                )
              ]),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Pin/Mark this special day'),
              ),
              Divider(
                color: Constants.secondaryColor,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                        onChanged: (val) {
                          eventdata = eventdata.copyWith(newtitle: val);
                        },
                        innerHint: 'Title',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                        maxlines: 8,
                        onChanged: (val) {
                          eventdata = eventdata.copyWith(newinfo: val);
                        },
                        textInputtype: TextInputType.multiline,
                        innerHint: 'What\'s special about this day',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      onPressed: () {
                        if (eventdata.title.isNotEmpty &&
                            eventdata.info.isNotEmpty) {
                          ref.watch(eventsProvider.notifier).saveEvent(
                              eventsHiveData: eventsHiveData,
                              value:
                                  eventdata.copyWith(newdate: widget.datetime));
                        }
                        Navigator.pop(context);
                        print(eventdata.title);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Text('Save',
                            style: Constants.defaultTextStyle
                                .copyWith(color: Colors.white)),
                      ),
                    ),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 20),
                        child: Text(
                          'Cancel',
                          style: Constants.defaultTextStyle
                              .copyWith(color: Colors.red),
                        ),
                      ),
                    )
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
