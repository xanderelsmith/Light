import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class DesktopTabBarName extends StatelessWidget {
  const DesktopTabBarName({
    super.key,
    required this.tabname,
    this.onTap,
    this.icon,
  });
  final VoidCallback? onTap;
  final String tabname;
  final Icon? icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tabname,
            style: TextStyle(color: Constants.primaryColor, fontSize: 15)),
        GestureDetector(
            onTap: () {
              onTap!();
            },
            child: icon ??
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: Constants.primaryColor,
                  size: 20,
                )),
      ],
    );
  }
}
