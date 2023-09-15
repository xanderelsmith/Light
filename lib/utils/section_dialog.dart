import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/models/section/sectionmodel.dart';
import 'package:light/repository/section/local_sections_storage_repo.dart';
import 'package:light/services/db_services/hivedb_functions.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/widgets/dualbutton_option.dart';

class SectionDialog extends ConsumerStatefulWidget {
  const SectionDialog({
    this.section,
    super.key,
    required this.isEdited,
  });
  final Section? section;
  final bool isEdited;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SectionDialogState();
}

class _SectionDialogState extends ConsumerState<SectionDialog> {
  late Section section;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    section = Section.initial;
  }

  @override
  Widget build(BuildContext context) {
    final sectionHiveData = Hive.box(HiveDb.sections);
    return Dialog(
        alignment: Alignment.center,
        child: SizedBox(
          width: 300,
          height: 600,
          child: Column(children: [
            Container(
              height: 100,
              width: double.maxFinite,
              color: Constants.secondaryColor,
              child: Center(
                  child: Text(
                'Add a Section',
                style: Constants.defaultTextStyle.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
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
                            section = section.copyWith(newname: val);
                          },
                          textCapitalization: TextCapitalization.words,
                          controller: TextEditingController(),
                          innerHint: 'Name'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SpecialTextfield(
                          onChanged: (val) {
                            section = section.copyWith(newDescription: val);
                          },
                          textCapitalization: TextCapitalization.words,
                          controller: TextEditingController(),
                          maxlines: 12,
                          innerHint: 'Description'),
                    ),
                  ]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: DualButtonOption(
                optionName: widget.isEdited ? 'Update' : 'Save',
                onSave: () {
                  if (section.name.isNotEmpty &&
                      section.description.isNotEmpty) {
                    ref.watch(sectionProvider.notifier).savesection(
                        sectionsHiveData: sectionHiveData, value: section);
                  }
                  Navigator.pop(context);
                  if (kDebugMode) {
                    print(section.name);
                  }
                },
              ),
            ),
          ]),
        ));
  }
}
