import 'package:flutter/material.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class SelectedUniversity extends StatefulWidget {
  const SelectedUniversity({super.key, required this.notifier});
  final ValueNotifier<University?> notifier;

  @override
  State<SelectedUniversity> createState() =>
      _SelectedUniversityState();
}

class _SelectedUniversityState extends State<SelectedUniversity> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<University?>(
        valueListenable: widget.notifier,
        builder: (context, value, child) => GestureDetector(
              onTap: () {
                launchModal(
                    context,
                    FilteredPage<University>(
                        mode: FilteredPageMode.Modal,
                        manager: ModelServiceFactory.UNIVERSITY,
                        searchable: true,
                        mapper: (club) => GestureDetector(
                              onTap: () {
                                widget.notifier.value = club;
                                closePage(context);
                                setState(() {});
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(club.schoolName,
                                    style: TextStyle(fontSize: 20)),
                              ),
                            ),
                        header: null));
              },
              child: RoundedTextField(
                type: TextInputType.none,
                controller: TextEditingController(text: value?.schoolName),
                hint: "Topluluk",
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
              ),
            ));
  }
}
