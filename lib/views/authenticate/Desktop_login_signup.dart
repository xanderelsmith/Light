import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/views/authenticate/signup.dart';
import 'package:light/views/homepage.dart';
import 'login.dart';
import 'package:light/utils/components.dart';
import 'dart:io';
import 'package:parse_server_sdk/parse_server_sdk.dart';

bool _ishidden = true;
int selectedAge = 0;
String status = 'nil';
FilePickerResult? result;

final fileProvider = StateProvider<File>((ref) {
  File file = File('images/boyavatar.png');
  return file;
});

class Login_SignUp_Switch extends StatelessWidget {
  Login_SignUp_Switch({Key? key, required this.showingLogin});
  final bool showingLogin;

  @override
  final kusernameController = TextEditingController();
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    int age = 0;

    return showingLogin == true
        ? LogIn(screensize: screensize, showingLogin: showingLogin)
        : SignUp(
            screensize: screensize,
          );
  }
}
