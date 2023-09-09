import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../styledWidget/desktopillustration.dart';
import '../utils/components.dart';
import 'package:light/views/authenticate/Desktop_login_signup.dart';

class DesktopOnboarding extends StatefulWidget {
  static String id = 'desktoponboarding';
  const DesktopOnboarding({Key? key}) : super(key: key);

  @override
  State<DesktopOnboarding> createState() => _DesktopOnboardingState();
}

bool switchreg = true;
//switch registration is a boolean to switch modes between login and signup
bool _ishidden = true;
Icon switchmode = const Icon(Icons.switch_left_sharp);

class _DesktopOnboardingState extends State<DesktopOnboarding>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _animation;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: konboardingDuration,
    );
    _animationController.repeat(reverse: true);
    _animation =
        Tween<double>(begin: 1, end: 13.0).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animation.isDismissed;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int? _iconSwitch;
    Size screensize = MediaQuery.of(context).size;
    Icon icon = const Icon(Icons.visibility);
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  color: kPrimaryColor,
                  child: Column(
                    children: [
                      Expanded(
                          child: DesktopIllustration(
                              updateValue: _animation.value,
                              image: killustrationPage[0].image,
                              title: killustrationPage[0].title,
                              details: killustrationPage[0].details)),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              child: DesktopIllustration(
                                  updateValue: _animation.value,
                                  image: killustrationPage[1].image,
                                  title: killustrationPage[1].title,
                                  details: killustrationPage[1].details),
                            ),
                            Expanded(
                              child: DesktopIllustration(
                                  updateValue: _animation.value,
                                  image: killustrationPage[2].image,
                                  title: killustrationPage[2].title,
                                  details: killustrationPage[2].details),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(child: Login_SignUp_Switch(showingLogin: switchreg))
            ],
          ),
          Align(
            alignment: const Alignment(0.344, 0),
            child: CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      switchreg = !switchreg;
                    });
                  },
                  icon: switchreg == true
                      ? const Icon(Icons.switch_left_sharp)
                      : const Icon(Icons.switch_right_sharp)),
            ),
          ),
        ],
      ),
    );
  }
}
