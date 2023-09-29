import 'package:ToGather/events/events.dart';
import 'package:ToGather/events/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/utilities/utilities.dart';

class BuilderSelectedEvent extends StatefulWidget {
  const BuilderSelectedEvent({super.key, required this.notifier, required this.user});
  final ValueNotifier<Event?> notifier;
  final Profile user;

  @override
  State<BuilderSelectedEvent> createState() => _BuilderSelectedEventState();
}

class _BuilderSelectedEventState extends State<BuilderSelectedEvent> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Event?>(
        valueListenable: widget.notifier,
        builder: (context, value, child) => GestureDetector(
              onTap: () {
                launchModal(
                    context,
                    FilteredPage<Event>(
                        mode: FilteredPageMode.Modal,
                        manager: ModelServiceFactory.EVENT,
                        searchable: true,
                        queryParameters: EventQueryParameters(
                          verfiedAttendee: widget.user,
                        ),
                        mapper: (club) => GestureDetector(
                              onTap: () {
                                widget.notifier.value = club;
                                closePage(context);
                                setState(() {});
                              },
                              child: AbsorbPointer(
                                child: SearchEvent(event: club),
                              ),
                            ),
                        header: null));
              },
              child: RoundedTextField(
                  type: TextInputType.none,
                  controller: TextEditingController(text: value?.title),
                  hint: "Etkinlik",
                  canClear: false,
                  editable: false,
                  showEditableColor: false,
                  suffix: [
                    if (value != null)
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () => setState(() {
                          widget.notifier.value = null;
                        }),
                      )
                  ],
                  prefix: [
                    if (value != null &&
                        value.media
                            .where((element) => element is NetworkImageData)
                            .isNotEmpty) ...[
                      SylvestImageProvider(
                          image: value.media
                              .where((element) => element is NetworkImageData)
                              .first as ImageData,
                          radius: 10,
                          defaultImage: null),
                      const SizedBox(width: 10)
                    ]
                  ]),
            ));
  }
}
