import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:light/styledWidget/eventsdatatile.dart';
import 'package:light/utils/constants.dart';

class NextEventsTab extends StatelessWidget {
  const NextEventsTab({
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
    return Column(
      children: [
        const Divider(color: Colors.brown, height: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Next Events',
                  style: Constants.defaultTextStyle, textAlign: TextAlign.left),
              Expanded(
                child: ListView.builder(
                    itemCount: events.length < 2 ? 0 : events.length - 1,
                    itemBuilder: (context, index) => EventTileWidget(
                          onTap: () {},
                          onDelete: () {
                            ref.watch(eventsProvider.notifier).delete(
                                index: index + 1,
                                eventsHiveData: eventsHiveData);
                          },
                          eventdata: events[index + 1],
                        )),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
