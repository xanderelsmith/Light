import 'package:flutter/material.dart';
import 'package:light/providers/quiz.dart';
import 'package:light/repository/quizcontroller.dart';
import 'package:light/repository/retrievedQuizRepository.dart';
import 'package:light/utils/apikeys.dart';
import 'package:light/utils/themes.dart';
import 'package:light/views/screens/homepage.dart';
import 'package:light/views/screens/quizscreen/multichoicequizscreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Parse().initialize(
      debug: true,
      ApiKeys.kappId,
      ApiKeys.keyParseServerUrl,
      clientKey: ApiKeys.kclientKey,
      autoSendSessionId: true);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => QuizController()),
      ChangeNotifierProvider(
        create: (context) => QuizRepoNotifier(),
      )
    ],
    child: FutureProvider<List<ParseObject>>(
        initialData: const [],
        create: (context) => Quiz.pullAllQuizes(),
        child: const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: MythemeModes.darkTheme,
      themeMode: ThemeMode.system,
      theme: MythemeModes.lightTheme,
      title: 'Quiz App',
      home: const Homepage(),
    );
  }
}

//Provider.of(context).