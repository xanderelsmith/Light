import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:spark_ai/controllers/quiz/coursebased_quizcontroller.dart';
import 'package:spark_ai/screens/quizscreens/mainquizscreen.dart';
import 'package:spark_ai/styledcomponents/courses_selector.dart';
import 'package:spark_ai/styledcomponents/customwidgets.dart';
import '../../models/course_details.dart';
import '../../models/quiz_details.dart';
import '../../repositories/quiz/retrieved_quizdata_repository.dart'
    show quizListProvider;
import '../../styledcomponents/linked_course_tile.dart';
import '../../utilities/courses_handlers.dart' show courseshandler;
import '../../utilities/styles.dart';
import '../creatematerials_ui/createquizscreen.dart';

class QuizDetailsScreen extends ConsumerStatefulWidget {
  const QuizDetailsScreen({
    required this.quizdetails,
    required this.thisUser,
    Key? key,
  }) : super(key: key);
  final QuizDetails quizdetails;
  final ParseUser thisUser;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizDetailsScreenState();
}

class _QuizDetailsScreenState extends ConsumerState<QuizDetailsScreen> {
  TextEditingController? coursecodeController;
  ScrollController scrollController = ScrollController();
  ParseObject? course;
  @override
  void initState() {
    super.initState();
    coursecodeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final quizlist = ref.watch(quizListProvider);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
            onPressed: () async {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => Center(
                      child: SpinKitDualRing(color: Styles.primaryThemeColor)));
              final questionList =
                  await CourseBasedQuizController.pullSingleQuizQuestions(
                topicname: widget.quizdetails.fullquizparsedata['topic_name']!,
                quizObject: widget.quizdetails.fullquizparsedata,
              );
              quizlist.inputData(questionList);

              Future.delayed(const Duration(milliseconds: 500), () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => MainQuizScreen(
                              topicname: widget
                                  .quizdetails.fullquizparsedata['topic_name']!,
                              coursecode: widget
                                  .quizdetails.fullquizparsedata['course_code'],
                              coursename: widget
                                  .quizdetails.fullquizparsedata['topic_name'],
                            ))));
              });
            },
            child: const Icon(Icons.play_arrow_rounded)),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.quizdetails.quizname,
                    style: Styles.titleTextStyle,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('--${widget.quizdetails.quizauthor.username!}'),
                ),
                widget.thisUser.username !=
                        widget.quizdetails.quizauthor.username
                    ? const SizedBox.shrink()
                    : FutureBuilder<List<CoursesDetails>>(
                        future: courseshandler.getCourseDetails(),
                        builder: (context, snapshot) {
                          return !snapshot.hasData
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CoursesSelector(
                                    axisdirection: AxisDirection.down,
                                    onChanged: (CoursesDetails value) async {
                                      setState(() {
                                        course = value.fullInstitutionParseData;
                                        print(course);
                                      });
                                    },
                                    typeAheadController: coursecodeController!,
                                    courses: courseshandler.courses,
                                  ),
                                );
                        },
                      ),
                course == null
                    ? const SizedBox.shrink()
                    : Column(
                        children: [
                          Center(
                              child: ElevatedButton(
                                  onPressed: () async {
                                    ParseRelation<ParseObject> relation =
                                        course!.getRelation('linkedquiz');
                                    relation.getQuery();
                                    relation.add(
                                        widget.quizdetails.fullquizparsedata);
                                    await course!.update().then((value) =>
                                        CustomWidgets.styledSnackBar(
                                            context: context,
                                            message:
                                                'Course detail added successfully'));
                                  },
                                  child: const Text('Add to linked Courses'))),
                        ],
                      ),
                Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: SizedBox(
                        width: double.maxFinite,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 8.0,
                                    ),
                                    child: Text('Description'),
                                  ),
                                  Text(
                                    widget.quizdetails.description,
                                    style: Styles.text,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16.0),
                                    child: Text('Linked Courses'),
                                  ),
                                  FutureBuilder<List<ParseObject>>(
                                      future: pullSingleQuizBasedCourses(
                                          quiz: widget
                                              .quizdetails.fullquizparsedata),
                                      builder: (context, snapshot) {
                                        return !snapshot.hasData
                                            ? Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Styles
                                                            .primaryThemeColor),
                                              )
                                            : Expanded(
                                                child: Scrollbar(
                                                  thumbVisibility: true,
                                                  interactive: true,
                                                  controller: scrollController,
                                                  child: ListView(
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    controller:
                                                        scrollController,
                                                    children: List.generate(
                                                        snapshot.data!.length,
                                                        (index) => Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          8.0),
                                                              child: LinkedCourseTile(
                                                                  quizdetails:
                                                                      widget
                                                                          .quizdetails,
                                                                  course: snapshot
                                                                          .data![
                                                                      index],
                                                                  quizOwner: widget
                                                                      .quizdetails
                                                                      .quizauthor,
                                                                  tiledata: snapshot
                                                                          .data![
                                                                      index],
                                                                  user: widget
                                                                      .thisUser),
                                                            )),
                                                  ),
                                                ),
                                              );
                                      })
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                )
              ],
            ),
            widget.thisUser.username == widget.quizdetails.quizauthor.username
                ? Align(
                    alignment: const Alignment(0.85, 0.7),
                    child: GestureDetector(
                        onTap: () {
                          ref
                              .watch(createdQuizlistdataProvider.notifier)
                              .validateAiInputData(widget
                                  .quizdetails.fullquizparsedata['questions']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateQuizScreen(
                                    quizdata:
                                        widget.quizdetails.fullquizparsedata),
                              ));
                        },
                        child: const CircleAvatar(
                          child: Icon(Icons.add),
                        )),
                  )
                : SizedBox.shrink(),
          ],
        ),
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: ClipOval(
                    child: widget.quizdetails.quizauthor['gender'] == 'Guy'
                        ? Image.asset('images/boyavatar.png')
                        : Image.asset('images/girlavatar.png'),
                  )),
            )
          ],
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.chevron_left_sharp)),
        ));
  }
}
