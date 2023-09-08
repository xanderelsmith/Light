import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';
import 'package:light/views/screens/courselist.dart';

class SlideCardWidget extends StatelessWidget {
  const SlideCardWidget({
    required this.info,
    required this.imageLoc,
    super.key,
    required this.screensize,
  });
  final String? info;
  final String? imageLoc;
  final Size screensize;

  @override
  Widget build(BuildContext context) {
    ;
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
          color: Constants.blueCard, borderRadius: BorderRadius.circular(10)),
      height: 100,
      width: screensize.width * 0.7,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.centerRight, child: Image.asset(imageLoc!)),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                info!,
                style: Constants.kminTextStyle
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CourseList(),
                        ));
                  },
                  child: const Text('Get Started'))
            ],
          ),
        ],
      ),
    );
  }
}
