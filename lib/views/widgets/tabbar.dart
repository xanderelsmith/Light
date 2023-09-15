import 'package:flutter/material.dart';
import 'package:light/utils/constants.dart';

class DesktopTabBarName extends StatelessWidget {
  const DesktopTabBarName({
    super.key,
    required this.tabname,
    this.onTap,
    this.icon,
    this.showIcon,
    this.customColor,
  });
  final VoidCallback? onTap;
  final String tabname;
  final Icon? icon;
  final Color? customColor;
  final bool? showIcon;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(tabname,
            style: TextStyle(
                color: customColor ?? Constants.primaryColor, fontSize: 15)),
        showIcon == null || showIcon == true
            ? GestureDetector(
                onTap: () {
                  onTap!();
                },
                child: icon ??
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: customColor ?? Constants.primaryColor,
                      size: 20,
                    ))
            : const SizedBox(),
      ],
    );
  }
}
