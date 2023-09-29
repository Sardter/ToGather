import 'package:ToGather/organizations/clubs/filters/query_params.dart';
import 'package:ToGather/users/users.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/modals/modals.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/utilities/utilities.dart';

enum BuilderSelectedClubState { Post, Event }

class BuilderSelectedClub extends StatefulWidget {
  const BuilderSelectedClub(
      {super.key,
      required this.notifier,
      required this.user,
      required this.state});
  final ValueNotifier<Club?> notifier;
  final Profile user;
  final BuilderSelectedClubState state;

  @override
  State<BuilderSelectedClub> createState() => _BuilderSelectedClubState();
}

class _BuilderSelectedClubState extends State<BuilderSelectedClub> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Club?>(
        valueListenable: widget.notifier,
        builder: (context, value, child) => GestureDetector(
              onTap: () {
                launchModal(
                    context,
                    FilteredPage<Club>(
                        mode: FilteredPageMode.Modal,
                        manager: ModelServiceFactory.CLUB,
                        searchable: true,
                        queryParameters:
                            ClubQueryParameters(canPostToClub: widget.user),
                        mapper: (club) => GestureDetector(
                              onTap: () {
                                widget.notifier.value = club;
                                closePage(context);
                                setState(() {});
                              },
                              child: AbsorbPointer(
                                child: SearchClub(club: club),
                              ),
                            ),
                        header: null));
              },
              child: RoundedTextField(
                  type: TextInputType.none,
                  controller: TextEditingController(text: value?.title),
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
                  prefix: [
                    if (value != null) ...[
                      SylvestImageProvider(
                          image: value.image, radius: 10, defaultImage: null),
                      const SizedBox(width: 10)
                    ]
                  ]),
            ));
  }
}
