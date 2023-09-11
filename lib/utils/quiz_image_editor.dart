import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:light/db_handler/styles.dart';

class QuizImageEditor extends StatefulWidget {
  const QuizImageEditor({
    super.key,
    required this.images,
  });

  final List? images;

  @override
  State<QuizImageEditor> createState() => _QuizImageEditorState();
}

class _QuizImageEditorState extends State<QuizImageEditor> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: PageView.builder(
          itemCount: widget.images!.length,
          itemBuilder: (context, index) => Column(
                children: [
                  Expanded(
                    child: InteractiveViewer(
                      child: CachedNetworkImage(
                        progressIndicatorBuilder: (context, url, progress) =>
                            Center(
                          child: CircularProgressIndicator(
                              color: Styles.primaryThemeColor),
                        ),
                        imageUrl: widget.images![index].url,
                        errorWidget: (context, url, error) => Center(
                          child: Center(
                            child: CircularProgressIndicator(
                                color: Styles.primaryThemeColor),
                          ),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  CustomButton(
                      onTap: () {
                        setState(() {
                          widget.images!.removeAt(index);
                        });
                      },
                      title: 'Delete')
                ],
              )),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.yellow[700],
          boxShadow: [
            BoxShadow(color: Colors.grey),
            BoxShadow(color: Colors.blueGrey)
          ],
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
