import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Desktoptextformfield extends StatelessWidget {
  final TextEditingController? textEditingController;
  final InputDecoration? inputdecoration;
  final TextInputType? textInputType;
  final double? height;
  final TextStyle? abouttextstyle;
  final String? text;
  final int? maxLines;
  const Desktoptextformfield({
    this.abouttextstyle,
    this.maxLines,
    this.inputdecoration,
    this.height,
    this.textInputType,
    required this.text,
    Key? key,
    this.textEditingController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(text ?? '', style: abouttextstyle),
          SizedBox(
            height: height ?? 35,
            child: TextField(
                maxLines: maxLines,
                style: const TextStyle(fontSize: 40, color: Colors.black),
                onChanged: ((value) => print(value)),
                decoration: inputdecoration ??
                    InputDecoration(
                        focusedBorder: OutlineInputBorder(),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(3))),
                keyboardType: textInputType,
                controller: textEditingController ?? TextEditingController()),
          )
        ],
      ),
    );
  }
}
