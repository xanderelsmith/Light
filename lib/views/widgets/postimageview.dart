import 'dart:io';

import 'package:flutter/material.dart';
import 'package:light/services/styles.dart';

class ImageViews extends StatefulWidget {
  const ImageViews({
    Key? key,
    required this.screenSize,
    required this.images,
    required this.index,
    required this.ontap,
    this.isoption,
  }) : super(key: key);

  final Size screenSize;
  final int index;
  final bool? isoption;
  final List images;
  final VoidCallback ontap;

  @override
  State<ImageViews> createState() => _ImageViewsState();
}

class _ImageViewsState extends State<ImageViews> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          child: InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: ((context) => Dialog(
                          child: SizedBox(
                        height: widget.screenSize.width,
                        child: widget.images.isEmpty
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: widget.screenSize.width / 3,
                                    color: Theme.of(context)
                                        .hintColor
                                        .withOpacity(0.1),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('No image added',
                                        style: Styles.text),
                                  )
                                ],
                              )
                            : Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InteractiveViewer(
                                  child: Image.file(
                                    File(
                                      widget.images[widget.index]!.path,
                                    ),
                                  ),
                                ),
                              ),
                      ))));
            },
            child: SizedBox(
                height: 100,
                width: widget.screenSize.width / 4.5,
                child: widget.images.isEmpty
                    ? Icon(
                        Icons.add_a_photo,
                        size: 70,
                        color: Theme.of(context).hintColor.withOpacity(0.1),
                      )
                    : Image.file(File(widget.images[widget.index]!.path))),
          ),
        ),
        widget.images.isEmpty || widget.isoption != null
            ? const SizedBox.shrink()
            : Positioned(
                bottom: 0,
                right: 0,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.ontap();
                    });
                  },
                  child: const Card(
                    child: Icon(Icons.close),
                  ),
                ),
              )
      ],
    );
  }
}
