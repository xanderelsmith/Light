import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/styledWidget/quiztypeoption_widget.dart';
import 'package:light/views/createquizui/previewcreatedquizscreen.dart';

class SideEditScreen extends StatelessWidget {
  const SideEditScreen({
    super.key,
    required this.ref,
    required this.child,
  });

  final WidgetRef ref;
  final PreviewQuizScreen child;
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
      IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close, color: Colors.red)),
      Center(
        child: QuizTypeSelectTile(ref: ref),
      ),
      Expanded(child: child),
    ]);
  }
}
