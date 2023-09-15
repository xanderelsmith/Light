import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class DualButtonOption extends StatelessWidget {
  const DualButtonOption({
    super.key,
    required this.onSave,
    this.optionName,
  });
  final VoidCallback onSave;
  final String? optionName;
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            onSave();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
            child: Text(optionName!,
                style:
                    Constants.defaultTextStyle.copyWith(color: Colors.white)),
          )),
      OutlinedButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Text(
            'Cancel',
            style: Constants.defaultTextStyle.copyWith(color: Colors.red),
          ),
        ),
      )
    ]);
  }
}
