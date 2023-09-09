import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:light/views/desktopOnboarding.dart';
import 'package:light/views/homepage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'db_handler/db_services/parseserverkeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
      debug: true,
      ParseKeys.kappId,
      ParseKeys.keyParseServerUrl,
      clientKey: ParseKeys.kclientKey,
      autoSendSessionId: true);
  //final bool boolisLoggedIn = await ApiService.hasUserLogged();
  runApp(ProviderScope(
    child: MaterialApp(initialRoute: DesktopOnboarding.id, routes: {
      DesktopOnboarding.id: (context) => const DesktopOnboarding(),
      HomePage.id: (context) => const HomePage()
    }),
  ));
}
