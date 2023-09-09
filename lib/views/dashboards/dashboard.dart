import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/views/dashboards/managementscreen.dart';

class HomeDashboard extends HookConsumerWidget {
  const HomeDashboard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollController = ScrollController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: 100,
            child: Card(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: FittedBox(
                          child: Text(
                        'Students',
                        style: TextStyle(fontSize: 12),
                      ))),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(
                            3,
                            (index) => const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: FittedBox(
                                    child: Column(
                                      children: [
                                        CircleAvatar(radius: 24),
                                        Text('Emmanuel Onyeji')
                                      ],
                                    ),
                                  ),
                                ))),
                  ),
                ],
              ),
            )),
          ),
        ),
        Expanded(
          flex: 5,
          child: Column(
            children: [
              Expanded(
                child: Card(
                  child: SizedBox(
                    height: double.maxFinite,
                    width: double.maxFinite,
                    child: Scrollbar(
                      thumbVisibility: true,
                      controller: scrollController,
                      child: ListView(
                          controller: scrollController,
                          scrollDirection: Axis.horizontal,
                          children: [
                            const QuestionAsset(),
                            ...List.generate(
                                3, (index) => QuestionAsset(index: index)),
                          ]),
                    ),
                  ),
                ),
              ),
              Expanded(
                  child: SizedBox(
                child: Row(
                    children: List.generate(
                        2,
                        (index) => Expanded(
                              child: Card(
                                child: Container(),
                              ),
                            ))),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class QuestionAsset extends StatelessWidget {
  const QuestionAsset({
    super.key,
    this.index,
  });
  final int? index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: double.maxFinite,
        width: 125,
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditQuiz(),
                ));
          },
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
              12,
            )),
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
            color: index != null ? Colors.grey[200] : Colors.grey,
            child: Center(
                child: index == null
                    ? const Icon(
                        Icons.add_circle_outline,
                        size: 100,
                      )
                    : null),
          ),
        ));
  }
}

class EditQuiz extends StatelessWidget {
  const EditQuiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close)),
            ],
          ),
          Expanded(
            child: Row(children: [
              Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.amber,
                  )),
              Expanded(
                child: Container(color: Colors.red),
              )
            ]),
          )
        ],
      ),
    );
  }
}
