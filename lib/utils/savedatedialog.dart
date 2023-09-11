import 'package:flutter/material.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/utils/constants.dart';
import 'package:light/models/calendermodels/event_data_model.dart';

class SaveDateDialog extends StatelessWidget {
  const SaveDateDialog({
    Key? key,
    required this.eventdata,
  }) : super(key: key);

  final EventData eventdata;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 200,
        height: 500,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text('Pin/Mark this special day'),
              const Divider(
                color: Constants.primaryColor,
              ),
              Expanded(
                flex: 4,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                        controller: TextEditingController(),
                        innerHint: 'Title',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                        maxlines: 8,
                        textInputtype: TextInputType.multiline,
                        innerHint: 'What\'\s special about this day',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Card(
                        color: Colors.amber,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 40),
                          child: Text('Save',
                              style: Constants.defaultTextStyle
                                  .copyWith(color: Colors.white)),
                        ),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 20),
                          child: Text('Cancel'),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
