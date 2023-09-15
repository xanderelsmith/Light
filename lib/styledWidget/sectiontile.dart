import 'package:flutter/material.dart';

class SectionTile extends StatelessWidget {
  const SectionTile({
    super.key,
    required this.title,
    required this.hasAddButton,
    required this.onTap,
    this.onDelete,
  });
  final String title;
  final bool hasAddButton;
  final VoidCallback onTap;
  final VoidCallback? onDelete;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            color: hasAddButton ? Colors.lightBlueAccent.shade200 : null,
            child: InkWell(
              onTap: () {
                onTap();
              },
              child: SizedBox(
                height: 50,
                child: InkWell(
                  onTap: () {
                    onTap();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        hasAddButton
                            ? const Padding(
                                padding: EdgeInsets.only(right: 18.0),
                                child: Icon(Icons.add_circle_outline_sharp,
                                    color: Colors.red),
                              )
                            : const SizedBox(),
                        Text(title)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        hasAddButton
            ? const SizedBox()
            : Card(
                child: InkWell(
                onTap: () => onDelete!(),
                child: Icon(
                  Icons.delete_forever_sharp,
                  color: Colors.red,
                ),
              ))
      ],
    );
  }
}
