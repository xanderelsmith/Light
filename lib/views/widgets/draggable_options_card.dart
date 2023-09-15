import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/controller/draggablequiz_controller.dart';
import 'package:light/services/styles.dart';
import 'package:light/styledWidget/specialtextfield.dart';
import 'package:light/views/createquizui/draggablequizcreator.dart';
class DraggableOptionCard extends StatelessWidget {
  const DraggableOptionCard({
    Key? key,
    required this.screenSize,
    required this.index,
    required this.ref,
    required this.questionsWatcher,
    required this.isEditing,
    required this.onEditedClick,
    required this.onEditingChange,
  }) : super(key: key);
  final WidgetRef ref;
  final Size screenSize;
  final int index;
  final DraggableQuestionListValueClass questionsWatcher;
  final bool isEditing;
  final VoidCallback onEditedClick;
  final Function onEditingChange;
  @override
  Widget build(BuildContext context) {
    var answerValue =
        ref.watch(questionListProvider.notifier).questionAnswer![index].answer!;
    final TextEditingController answerController =
        TextEditingController(text: answerValue);
    return Card(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isEditing == false
                  ? Flexible(child: Text(answerValue, style: Styles.text))
                  : Expanded(
                      child: SpecialTextfield(
                      controller: answerController,
                      onChanged: (String value) {
                        onEditingChange(value);
                      },
                    )),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ref
                                .watch(questionListProvider.notifier)
                                .questionlistValue!
                                .contains(questionsWatcher
                                    .questionAnswerValues![index]) ==
                            true
                        ? const SizedBox()
                        : ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isEditing == false
                                  ? Theme.of(context)
                                      .canvasColor
                                      .withOpacity(0.3)
                                  : Colors.green,
                              shape: const CircleBorder(),
                            ),
                            onPressed: () {
                              onEditedClick();
                            },
                            child: const ClipOval(
                              child: Icon(Icons.border_color),
                            )),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const CircleBorder(),
                      ),
                      onPressed: () {
                        ref.watch(questionListProvider);
                        questionsWatcher.deleteoption(
                            value: ref
                                .watch(questionListProvider.notifier)
                                .questionAnswer![index]);
                      },
                      child: const ClipOval(
                        child: Icon(Icons.close),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
