import '../utils/components.dart';
import 'package:flutter/material.dart';

class DesktopIllustration extends StatefulWidget {
  final String image;
  final double updateValue;
  final String title;
  final String details;
  const DesktopIllustration(
      {Key? key,
      required this.image,
      required this.title,
      required this.details,
      required this.updateValue})
      : super(key: key);

  @override
  State<DesktopIllustration> createState() => _DesktopIllustrationState();
}

class _DesktopIllustrationState extends State<DesktopIllustration> {
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
                  widget.image,
                ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  decoration: const BoxDecoration(),
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Flexible(
                        child: Text(widget.title,
                            style: kdesktopTextStyle.kminTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                      Flexible(
                        child: Text(
                          widget.details,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]));
  }
}
