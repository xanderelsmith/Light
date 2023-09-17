import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/section/sectionmodel.dart';
import 'package:light/repository/events/eventrepository.dart';
import 'package:light/repository/section/local_sections_storage_repo.dart';
import 'package:light/services/storage/hivedb_functions.dart';
import 'package:light/styledWidget/sectiontile.dart';
import 'package:light/utils/constants.dart';
import 'package:light/utils/section_dialog.dart';
import 'package:light/views/widgets/tabbar.dart';

class SectionTab extends ConsumerStatefulWidget {
  const SectionTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SectionTabState();
}

class _SectionTabState extends ConsumerState<SectionTab> {
  DateTime? dateTime;
  List<Section> sections = [];
  final sectionsHiveData = Hive.box(HiveDb.sections);
  @override
  void initState() {
    super.initState();
    sections = refreshSections(sectionsHiveData)
        .map((e) => Section(
            createdDate: e['createdDate'],
            description: e['description'],
            name: e['name']))
        .toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref.watch(sectionProvider.notifier).assign(sections);
  }

  @override
  Widget build(BuildContext context) {
    sections = ref.watch(sectionProvider);
    final sectionHiveData = Hive.box(HiveDb.sections);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const DesktopTabBarName(tabname: 'Section', showIcon: false),
            Flexible(
                child: GridView.builder(
                    itemCount: sections.length,
                    //always increase the list length by 1 to compensate for the addSection feature

                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            crossAxisSpacing: 40,
                            mainAxisExtent: 50,
                            maxCrossAxisExtent: 250),
                    itemBuilder: (context, index) => SectionTile(
                          title: sections[index].name,
                          onDelete: () {
                            ref.watch(sectionProvider.notifier).delete(
                                sectionsHiveData: sectionHiveData,
                                index: index);
                          },
                          hasAddButton: false,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  const SectionDialog(isEdited: true),
                            );
                          },
                        ))),
            SizedBox(
              width: 200,
              height: 50,
              child: SectionTile(
                hasAddButton: true,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SectionDialog(isEdited: false),
                  );
                },
                title: 'Add Section',
              ),
            )
          ],
        ),
      ),
    );
  }
}
