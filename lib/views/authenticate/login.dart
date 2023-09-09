import 'dart:async';
import 'package:flutter/material.dart';
import 'package:light/views/authenticate/reset_password.dart';
import 'package:parse_server_sdk/parse_server_sdk.dart';

import '../../db_handler/db_services/api_services.dart';
import '../../db_handler/styles.dart';
import '../../styledWidget/specialtextfield.dart';

import '../homepage.dart';

class LogIn extends StatefulWidget {
  static String id = 'login';
  LogIn({Key? key, required this.screensize, required this.showingLogin})
      : super(key: key);
  final Size screensize;
  bool showingLogin;
  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final controllerPassword = TextEditingController();
  final controllerUsername = TextEditingController();
  String password = '';
  bool isLoggedIn = false;

  bool ishidden = true;
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          leadingWidth: 20,
          elevation: 0,
          title: Text('Sync', style: Styles.text.copyWith(color: Colors.black)),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Image.asset(
                    'images/S_AI.png',
                  ),
                ),
                Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(10)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      children: [
                        SpecialTextfield(
                            ishidden: false,
                            suffixwidget: null,
                            controller: controllerUsername,
                            textCapitalization: TextCapitalization.none,
                            textInputtype: TextInputType.name,
                            textfieldname: 'Username'),
                        const SizedBox(
                          height: 40,
                        ),
                        SpecialTextfield(
                            ishidden: ishidden,
                            controller: controllerPassword,
                            suffixwidget: IconButton(
                                onPressed: () {
                                  setState(() {
                                    ishidden = !ishidden;
                                  });
                                },
                                icon: ishidden
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            textCapitalization: TextCapitalization.none,
                            textInputtype: TextInputType.visiblePassword,
                            textfieldname: 'Password'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResetPassword()));
                                },
                                child: const Text('Forgot Password?'))
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: Size(screensize.width / 1.2, 50)),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()));
                              if (controllerPassword.text.isNotEmpty &&
                                  controllerUsername.text.isNotEmpty &&
                                  controllerPassword.text.isNotEmpty) {
                                await showDialog(
                                    builder: (context) {
                                      bool isSuccessful = false;
                                      return FutureBuilder(
                                        future: ApiService.doUserLogin(
                                          username: controllerUsername.text,
                                          password: controllerPassword.text,
                                        ),
                                        builder: (BuildContext context,
                                            AsyncSnapshot<ParseResponse>
                                                snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            isSuccessful =
                                                snapshot.data!.success;
                                            if (isSuccessful == true) {
                                              Future.delayed(
                                                  const Duration(seconds: 2),
                                                  () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            HomePage()));
                                              });
                                            }

                                            if (snapshot.data!.success ==
                                                false) {
                                              return AlertDialog(
                                                  content: Text(snapshot.data!
                                                              .statusCode ==
                                                          -1
                                                      ? 'Enable internet connection'
                                                      : snapshot.data!.error!
                                                          .message));
                                            }
                                          }
                                          {
                                            return Center(
                                              child: CircularProgressIndicator(
                                                color: Styles.primaryThemeColor,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                    context: context);
                              } else {
                                if (controllerPassword.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('password field is empty')));
                                } else if (controllerUsername.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Username field is empty')));
                                }
                              }
                            },
                            child: const Text('Log in')),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ))
              ]),
        ));
  }
}
