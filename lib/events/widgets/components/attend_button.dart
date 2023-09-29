import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/utilities.dart';

class AttendButton extends StatefulWidget {
  AttendButton({required this.event});

  final Event event;

  @override
  State<AttendButton> createState() => AttendButtonState();
}

class AttendButtonState extends State<AttendButton> {
  late bool _isAttending = widget.event.requestData.isAttending;

  Future<bool> _attend() async {
    FormResponse? formResponse = null;

    if (!_isAttending) {
      if (widget.event.formData != null && widget.event.formData!.isNotEmpty) {
        formResponse = await showDialog(
            context: context,
            builder: (context) {
              return AttendForm(
                  event: widget.event,
                  items: widget.event.formData
                          ?.map((e) => FormBlockController.fromData(e))
                          .toList() ??
                      []);
            });
        if (formResponse == null) return false;
      }
    }
    final response = await ModelServiceFactory.EVENT.attend(
        itemParameters: ItemParameters(id: widget.event.id),
        formResponse: formResponse);
    if (response == null) {
      await showSylvestSnackbar(
          context: context,
          message: "Etkinliğe katılınamadı",
          type: DisplayMessageType.Danger);
      return false;
    }
    _isAttending = !_isAttending;
    setState(() {});

    await showSylvestSnackbar(
        context: context,
        message: _isAttending
            ? "Etkinliğe katıldın!"
            : "Etkinliği katılımdan çıkardın",
        type: DisplayMessageType.Success);

    closePage(context);
    launchPage(context, EventPage(id: widget.event.id));

    return _isAttending;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _attend,
      child: SylvestCard(
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(ThemeService.borderRadiusValue)),
        padding: const EdgeInsets.all(10),
        background:
            !_isAttending ? ThemeService.eventColor : ThemeService.postColor,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineIcons.calendar,
              color: ThemeService.onContrastColor,
            ),
            SizedBox(width: 10),
            Text(_isAttending ? "Katılıyorsun!" : "Katıl",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: ThemeService.onContrastColor,
                )),
            VerticalDivider(
              color: ThemeService.onContrastColor.withOpacity(0.7),
              indent: 10,
              endIndent: 10,
            ),
            Text(_isAttending ? "Vazgeç" : "Bedava",
                style: TextStyle(
                    color: ThemeService.onContrastColor.withOpacity(0.7)))
          ],
        ),
      ),
    );
  }
}
