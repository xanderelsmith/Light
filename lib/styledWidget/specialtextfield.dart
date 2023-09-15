import 'package:flutter/material.dart';

class SpecialTextfield extends StatelessWidget {
  final String? textfieldname;
  final String? innerHint;

  final TextInputType? textInputtype;
  final Widget? suffixwidget;
  final Function(String)? onChanged;
  final TextCapitalization? textCapitalization;
  const SpecialTextfield({
    Key? key,
    this.maxlines,
    this.controller,
    this.ishidden,
    this.onChanged,
    this.suffixwidget,
    this.textCapitalization,
    this.textInputtype,
    this.textfieldname,
    this.enableSuggestion,
    this.isMultiline,
    this.innerHint,
    this.decoration,
  }) : super(key: key);
  final bool? ishidden;
  final InputDecoration? decoration;
  final bool? enableSuggestion;
  final TextEditingController? controller;
  final bool? isMultiline;
  final int? maxlines;
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value);
        }
      },
      controller: controller,
      keyboardType: textInputtype,
      obscureText: ishidden ?? false,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      autocorrect: false,
      maxLines: maxlines,
      enableSuggestions: enableSuggestion ?? false,
      decoration: decoration ??
          InputDecoration(
            labelText: textfieldname,
            hintStyle: const TextStyle(fontWeight: FontWeight.w300),
            hintText: innerHint,
            filled: true,
            suffixIcon: suffixwidget,
            border: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black)),
          ),
    );
  }
}
