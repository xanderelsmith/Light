import 'package:flutter/material.dart';

class EditEventScreen extends StatelessWidget {
  const EditEventScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Dialog(
      alignment: Alignment.centerRight,
      child: SizedBox(
        width: 400,
        height: screensize.height,
        child: Column(
          children: [
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      fixedSize: const Size(300, 30)),
                  onPressed: () {},
                  child: const Text('Update')),
            )
          ],
        ),
      ),
    );
  }
}
