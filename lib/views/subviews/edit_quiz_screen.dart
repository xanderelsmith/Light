import 'package:flutter/material.dart';
import 'package:light/views/createquizui/createquizscreen.dart';

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
                    child: CreateQuizScreen(),
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
