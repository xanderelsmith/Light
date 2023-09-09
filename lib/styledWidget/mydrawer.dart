import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/db_handler/db_services/api_services.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../db_handler/styles.dart';
import '../enums/PagesEnum.dart';
import '../views/authenticate/Desktop_login_signup.dart';
import '../views/homepage.dart';

class StyledDrawer extends HookConsumerWidget {
  const StyledDrawer({
    required this.user,
    Key? key,
    required this.setPage,
  }) : super(key: key);

  final PageLocale setPage;
  final ParseUser? user;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.amber,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: FittedBox(
                child: Text(
                  'Spark ',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
              child: SizedBox(
                height: 100,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                useOldImageOnUrlChange: true,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                                imageUrl: user?['imageurl'] ?? '',
                                errorWidget: (context, url, error) =>
                                    Image.asset(
                                  'images/boyavatar.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.cover,
                                ),
                                placeholder: (context, url) => Center(
                                  child: SpinKitPulse(
                                    color: Styles.primaryThemeColor,
                                  ),
                                ),
                              ),
                            ))),
                    Align(
                        alignment: const Alignment(0.35, 1),
                        child: GestureDetector(
                          onTap: () async {
                            try {
                              result = await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  type: FileType.image,
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
                              ParseFileBase? parseFile;
                              parseFile = ParseFile(ref.watch(fileProvider));
                              final user = await ApiService.getUser();
                              user.set('schoolLogo', parseFile);
                              await user.save();
                              await user.update();
                              ref.watch(fileProvider);
                            } on Exception catch (e) {
                              print(e);
                            }
                          },
                          child: const CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 10,
                              child: const Icon(
                                Icons.camera_sharp,
                                size: 15,
                              )),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: RichText(
            textAlign: TextAlign.left,
            text: TextSpan(children: <TextSpan>[
              const TextSpan(text: 'Name: '),
              TextSpan(
                  text: user != null
                      ? '${user!['firstname']} ${user!['surname']}'
                      : 'Admin')
            ]),
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text('Greater Grace Schools')),
        Expanded(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(
              5,
              (index) => Container(
                    decoration: BoxDecoration(
                        color: setPage == homePageEnum(index)
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                            left: Radius.circular(5))),
                    margin: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    width: double.maxFinite,
                    child: InkWell(
                      enableFeedback: true,
                      onTap: () {
                        print(setPage);
                        ref
                            .read(pageNavProvider.notifier)
                            .changevalue(homePageEnum(index));
                      },
                      child: Row(
                        children: [
                          FittedBox(
                            child: TextButton.icon(
                                style: TextButton.styleFrom(
                                    enableFeedback: false,
                                    primary: setPage == homePageEnum(index)
                                        ? Colors.white
                                        : Colors.transparent),
                                onPressed: null,
                                icon: Icon(
                                  homePageEnum(index).iconData,
                                  color: Colors.black,
                                ),
                                label: Text(
                                  homePageEnum(index).value,
                                  style: const TextStyle(
                                      color: Colors.greenAccent),
                                )),
                          ),
                        ],
                      ),
                    ),
                  )),
        )),
      ]),
    );
  }
}
