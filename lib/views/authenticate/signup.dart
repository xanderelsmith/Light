import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/utils/components.dart';
import 'package:flutter/material.dart';
import 'package:light/views/authenticate/Desktop_login_signup.dart';
import 'package:light/views/homepage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../services/db_services/api_services.dart';
import '../../services/styles.dart';

class SignUp extends ConsumerWidget {
  SignUp({Key? key, required this.screensize}) : super(key: key);
  final Size screensize;

  @override
  final ishiddenProvider = StateProvider<bool>((ref) {
    return false;
  });
  TextEditingController controllerUsername = TextEditingController();
  TextEditingController controllerSurname = TextEditingController();
  TextEditingController controllerFirstname = TextEditingController();
  TextEditingController controllerSchoolName = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 20,
        elevation: 0,
        title: Text('Sync', style: Styles.text.copyWith(color: Colors.black)),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Flexible(
              flex: 5,
              //body of the login state
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Surname',
                                style: kdesktopTextStyle.kminTextStyle
                                    .copyWith(fontSize: 15),
                              ),
                              TextField(
                                controller: controllerSurname,
                                keyboardType: TextInputType.emailAddress,
                                style: kdesktopTextStyle.kminTextStyle,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: const InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: 'jonathan ',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 2,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'First name',
                                style: kdesktopTextStyle.kminTextStyle
                                    .copyWith(fontSize: 15),
                              ),
                              TextField(
                                controller: controllerFirstname,
                                keyboardType: TextInputType.emailAddress,
                                style: kdesktopTextStyle.kminTextStyle,
                                textAlignVertical: TextAlignVertical.bottom,
                                decoration: const InputDecoration(
                                    filled: true,
                                    contentPadding: EdgeInsets.only(bottom: 10),
                                    hintText: '   hugh',
                                    hintStyle:
                                        TextStyle(fontWeight: FontWeight.w300)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account Username',
                          style: kdesktopTextStyle.kminTextStyle
                              .copyWith(fontSize: 15),
                        ),
                        TextField(
                          controller: controllerUsername,
                          keyboardType: TextInputType.emailAddress,
                          style: kdesktopTextStyle.kminTextStyle,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon: Icon(Icons.notifications_none_rounded),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text('Do not add spaces'),
                                              content: Text(
                                                  'All characters should be written together in lowercase e.g  '),
                                            ));
                                  }),
                              filled: true,
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: ' e.g sparkschools ',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'School Name',
                          style: kdesktopTextStyle.kminTextStyle
                              .copyWith(fontSize: 15),
                        ),
                        TextField(
                          controller: controllerSchoolName,
                          keyboardType: TextInputType.emailAddress,
                          style: kdesktopTextStyle.kminTextStyle,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: ' Spark High School ',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 30,
                      ),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              try {
                                result = await FilePicker.platform.pickFiles(
                                    allowedExtensions: [
                                      'jpg',
                                      'png',
                                      'jpeg',
                                      'gif',
                                      'tiff'
                                    ]);
                                if (result != null) {
                                  ref.watch(fileProvider.notifier).state =
                                      File(result!.files.single.path!);
                                } else {}
                              } on Exception catch (e) {
                                print(e);
                              }
                            },
                            child: Card(
                              color: Colors.grey,
                              child: SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Image.file(
                                          ref.watch(fileProvider)!,
                                          fit: BoxFit.fitHeight,
                                        ),
                                      ),
                                      ref.watch(fileProvider).path ==
                                                  'images/boyavatar.png' ||
                                              ref
                                                  .watch(fileProvider)
                                                  .path
                                                  .isEmpty
                                          ? Align(
                                              alignment: Alignment.bottomRight,
                                              child: const Icon(
                                                Icons
                                                    .add_photo_alternate_outlined,
                                              ),
                                            )
                                          : const SizedBox(),
                                    ],
                                  )),
                            ),
                          ),
                          ref.watch(fileProvider).path ==
                                      'images/boyavatar.png' ||
                                  ref.watch(fileProvider).path.isEmpty
                              ? const Text('Add Your School\'s logo')
                              : const SizedBox()
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Email',
                          style: kdesktopTextStyle.kminTextStyle
                              .copyWith(fontSize: 15),
                        ),
                        TextField(
                          controller: controllerEmail,
                          keyboardType: TextInputType.emailAddress,
                          style: kdesktopTextStyle.kminTextStyle,
                          textAlignVertical: TextAlignVertical.bottom,
                          decoration: const InputDecoration(
                              filled: true,
                              contentPadding: EdgeInsets.only(bottom: 10),
                              hintText: '  Your_Email_example@gmail.com',
                              hintStyle:
                                  TextStyle(fontWeight: FontWeight.w300)),
                        ),
                      ],
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Password',
                            style: kdesktopTextStyle.kminTextStyle
                                .copyWith(fontSize: 15),
                          ),
                          TextField(
                            controller: controllerPassword,
                            obscureText: ref.watch(ishiddenProvider),
                            style: kdesktopTextStyle.kminTextStyle,
                            textAlignVertical: TextAlignVertical.bottom,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(bottom: 0),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    ref.watch(ishiddenProvider.notifier).state =
                                        ref.watch(ishiddenProvider) == true
                                            ? false
                                            : true;
                                  },
                                  icon: ref.watch(ishiddenProvider) == true
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off)),
                              filled: true,
                            ),
                          )
                        ]),
                    Flexible(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                fixedSize: const Size(20, 50)),
                            onPressed: () async
                             {
                              if (controllerEmail.text.isNotEmpty &&
                                  controllerUsername.text.isNotEmpty &&
                                  controllerPassword.text.isNotEmpty &&
                                  controllerSurname.text.isNotEmpty &&
                                  controllerSchoolName.text.isNotEmpty) {
                                await showDialog(
                                    builder: (context) {
                                      bool isSuccessful = false;
                                      return FutureBuilder(
                                        future: ApiService.doUsersignUp(
                                          username: controllerUsername.text,
                                          password: controllerPassword.text,
                                          emailadress: controllerEmail.text,
                                          controllerFirstname:
                                              controllerFirstname,
                                          controllerSchoolName:
                                              controllerSchoolName,
                                          controllerSurname: controllerSurname,
                                          file: ref.watch(fileProvider),
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
                                                            const HomePage()));
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
                                              child: SpinKitChasingDots(
                                                duration:
                                                    const Duration(seconds: 5),
                                                color: Styles.primaryThemeColor,
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    },
                                    context: context);
                              } else {
                                if (controllerEmail.text.isEmpty) {
                                  ScaffoldMessenger.of(context)
                                      .clearSnackBars();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content:
                                              Text('Email Field is empty')));
                                } else if (controllerPassword.text.isEmpty) {
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
                            child: const Text('Sign Up'))),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 10),
                            color: Colors.grey,
                            height: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
