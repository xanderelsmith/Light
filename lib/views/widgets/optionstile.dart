
import 'package:flutter/material.dart';

class OptionTile extends StatelessWidget {
  const OptionTile({
    required this.colorInfo,
    required this.imageloc,
    required this.info,
    super.key,
  });
  final Color colorInfo;
  final String info;
  final String imageloc;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 100,
      child: Stack(
        children: [
          Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                  height: 70, width: 150, child: Card(color: colorInfo))),
          Align(alignment: Alignment.bottomLeft, child: Image.asset(imageloc)),
          Align(
              alignment: const Alignment(0.86, 0.8),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2,
                  ),
                  child: Text(info, style: TextStyle(color: colorInfo)),
                ),
              ))
        ],
      ),
    );
  }
}
