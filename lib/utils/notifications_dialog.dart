import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/notifications.dart';
import 'package:light/notifiers/notifications_repo.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/widgets/dualbutton_option.dart';

class NotificationsDialog extends ConsumerStatefulWidget {
  const NotificationsDialog({
    this.activenotification,
    super.key,
    required this.isEdited,
  });
  final ActiveNotification? activenotification;
  final bool isEdited;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _NotificationsDialogState();
}

class _NotificationsDialogState extends ConsumerState<NotificationsDialog> {
  late ActiveNotification activenotification;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    activenotification = ActiveNotification.initial;
  }

  @override
  Widget build(BuildContext context) {
    final activenotificationHiveData = Hive.box(HiveDb.notificationsBox);
    return Dialog(
        alignment: Alignment.center,
        child: SizedBox(
          width: 300,
          height: 600,
          child: Column(children: [
            Container(
              height: 100,
              width: double.maxFinite,
              color: Colors.blueAccent,
              padding: const EdgeInsets.all(10),
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Add a Notification',
                    style: Constants.defaultTextStyle
                        .copyWith(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Notifications added would be shown to designated users',
                    style: Constants.defaultTextStyle.copyWith(
                        color: Colors.black, fontWeight: FontWeight.w700),
                  )
                ],
              )),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                          onChanged: (val) {
                            activenotification =
                                activenotification.copyWith(newTitle: val);
                          },
                          textCapitalization: TextCapitalization.words,
                          controller: TextEditingController(),
                          innerHint: 'Title'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                          onChanged: (val) {
                            activenotification = activenotification.copyWith(
                                newDescription: val);
                          },
                          textCapitalization: TextCapitalization.words,
                          controller: TextEditingController(),
                          maxlines: 12,
                          innerHint: 'Information'),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DualButtonOption(
                optionName: widget.isEdited ? 'Update' : 'Save',
                onSave: () {
                  if (activenotification.title.isNotEmpty &&
                      activenotification.description.isNotEmpty) {
                    ref
                        .watch(activenotificationProvider.notifier)
                        .saveNotification(
                            notificationsHiveData: activenotificationHiveData,
                            value: activenotification);
                  }
                  Navigator.pop(context);
                  if (kDebugMode) {
                    print(activenotification.title);
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
