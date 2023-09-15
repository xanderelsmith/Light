import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:light/utils/constants.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../services/styles.dart';
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
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
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
                                    Container(color: Colors.blue),
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
                              dynamic user;
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
            child: Text(
              Constants.appname,
              textAlign: TextAlign.center,
            )),
        Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: List.generate(
                  4,
                  (index) => Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            color: setPage == homePageEnum(index)
                                ? Constants.secondaryColor
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(5)),
                        margin: const EdgeInsets.symmetric(horizontal: 10),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FittedBox(
                                child: TextButton(
                                  onPressed: null,
                                  child: Icon(
                                    homePageEnum(index).iconData,
                                    size: 30,
                                    color: setPage != homePageEnum(index)
                                        ? Constants.primaryColor.withOpacity(1)
                                        : Colors.white,
                                  ),
                                ),
                              ),
                              Text(
                                homePageEnum(index).value,
                                style: Constants.defaultTextStyle,
                              )
                            ],
                          ),
                        ),
                      )),
            )),
        Expanded(child: SizedBox())
      ]),
    );
  }
}
