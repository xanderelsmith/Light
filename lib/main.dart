import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:light/services/storage/hivedb_functions.dart';

import 'package:light/views/homepage.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'internals/parseserverkeys.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await hivedbEndPoint();

  await Parse().initialize(
      debug: true,
      ParseKeys.kappId,
      ParseKeys.keyParseServerUrl,
      clientKey: ParseKeys.kclientKey,
      autoSendSessionId: true);
  runApp(ProviderScope(
    child: MaterialApp(
        initialRoute: HomePage.id,
        routes: {HomePage.id: (context) => const HomePage()}),
  ));
}
