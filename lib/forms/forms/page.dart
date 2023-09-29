import 'package:ToGather/forms/forms_responses/form_responses.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/forms/blocks/blocks.dart';
import 'package:ToGather/forms/forms/forms.dart';
import 'package:ToGather/utilities/utilities.dart';

class AttendForm extends StatefulWidget {
  final List<FormBlockController> items;
  final Event event;

  AttendForm({Key? key, required this.items, required this.event}) : super(key: key) {}

  factory AttendForm.fromJson(List<Map<String, dynamic>> json,
      {required Event event}) {
    return AttendForm(
      items: json
          .map((e) => FormBlockController.fromData(FormBlockData.fromJson(e)))
          .toList(),
      event: event,
    );
  }

  @override
  State<AttendForm> createState() => AttendFormState();
}

class AttendFormState extends State<AttendForm> {
  bool _validate(BuildContext context) {
    bool valid = true;
    widget.items.forEach((block) {
      if (!block.isValid) {
        valid = false;
        return;
      }
    });
    if (!valid) {
      /* APIService.displayError(
          LanguageService().data.errors.formInvalid, context); */
    }
    return valid;
  }

  Future<FormResponse?> _onSubmit(BuildContext context) async {
    if (!_validate(context)) return null;

    final result = FormResponse(
        id: 0,
        author: (await ModelServiceFactory.PROFILE.getCurrentUser(context, launchLogin: false))!,
        event: widget.event,
        date: DateTime.now(),
        allowedActions: null,
        data: widget.items.map((e) => e.data).toList());

    closePage(context, result: result);

    return result;
  }

  Widget _submitButton(BuildContext context) {
    return SylvestButton(
        maximizeLength: true,
        children: [
          Icon(LineIcons.paperclip),
          SizedBox(width: 10),
          Text(LanguageService().data.sharable.confirm)
        ],
        onTap: () async => await _onSubmit(context) == null);
  }

  Widget _canncelButton(BuildContext context) {
    return OutlinedButton(
        style: OutlinedButton.styleFrom(
            foregroundColor: ThemeService.eventColor,
            fixedSize: Size(double.maxFinite, 35),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
        onPressed: () => closePage(context),
        child: Text(LanguageService().data.sharable.cancel));
  }

  @override
  Widget build(context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Align(
          child: ListView(
            physics:
                AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            children: [
              SylvestCard(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(LanguageService().data.form.title,
                          style:
                              TextStyle(fontFamily: 'Quicksand', fontSize: 18)),
                      SizedBox(height: 10),
                      ...widget.items.map((e) => e.widget),
                      _submitButton(context),
                      _canncelButton(context),
                      SizedBox(height: 10)
                    ],
                  ))
            ],
          ),
        ));
  }
}
