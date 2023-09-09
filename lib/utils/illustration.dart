import '../utils/components.dart';
import 'package:flutter/material.dart';

class Illustration extends StatelessWidget {
  final String image;
  final String title;
  final String details;
  const Illustration(
      {Key? key,
      required this.image,
      required this.title,
      required this.details})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
        height: height,
        width: width,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Image.asset(
                  image,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Text(title,
                          style: kdesktopTextStyle.kmaxTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        details,
                        style: kdesktopTextStyle.kminTextStyle,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              )
            ]));
  }
}
