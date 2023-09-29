import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class DismissableFromBlock extends StatelessWidget {
  const DismissableFromBlock(
      {Key? key,
      required this.id,
      required this.onDismiss,
      required this.child})
      : super(key: key);
  final int id;
  final void Function(int) onDismiss;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) => onDismiss(id),
      child: DottedBorder(
          color: ThemeService.unusedColor,
          padding: const EdgeInsets.all(10),
          radius: const Radius.circular(10),
          borderType: BorderType.RRect,
          child: child),
    );
  }
}