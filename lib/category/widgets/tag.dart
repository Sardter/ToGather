import 'package:flutter/material.dart';

class TagWidget extends StatelessWidget {
  const TagWidget(
      {Key? key,
      required this.title,
      required this.index,
      required this.onDeleted})
      : super(key: key);
  final String title;
  final int index;
  final void Function(int index) onDeleted;

  @override
  Widget build(BuildContext context) {
    return Chip(
        onDeleted: () => onDeleted(index),
        backgroundColor: Colors.grey.shade900,
        label: Text(title, style: const TextStyle(fontSize: 11)),
        deleteIcon: const Icon(
          Icons.close,
          size: 15,
        ),
        labelPadding: const EdgeInsets.symmetric(vertical: -2, horizontal: 5));
  }
}