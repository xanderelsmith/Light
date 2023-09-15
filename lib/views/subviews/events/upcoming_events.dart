import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:light/styledWidget/eventsdatatile.dart';
import 'package:light/utils/constants.dart';

class UpcomingEventsTaB extends StatelessWidget {
  const UpcomingEventsTaB({
    super.key,
    required this.events,
    required this.ref,
    required this.eventsHiveData,
  });

  final List events;
  final WidgetRef ref;
  final Box eventsHiveData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Upcoming Event',
          textAlign: TextAlign.start,
          style: Constants.defaultTextStyle,
        ),
        Expanded(
            child: events.isNotEmpty
                ? EventTileWidget(
                    onTap: () {},
                    onDelete: () {
                      ref
                          .watch(eventsProvider.notifier)
                          .delete(index: 0, eventsHiveData: eventsHiveData);
                    },
                    eventdata: events.first,
                  )
                : const SizedBox())
      ]),
    );
  }
}
