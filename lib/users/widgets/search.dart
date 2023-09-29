import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class SearchUser extends StatefulWidget {
  const SearchUser(
      {Key? key,
      required this.profileData,
      this.selectable = false,
      this.dissmisable = false,
      this.onSelect})
      : super(key: key);
  final Profile profileData;
  final bool selectable;
  final bool dissmisable;
  final void Function(Profile data)? onSelect;

  @override
  State<SearchUser> createState() => _SearchUserState();
}

class _SearchUserState extends State<SearchUser> {
  @override
  Widget build(BuildContext context) {
    return SylvestCard(
        height: 170,
        padding: EdgeInsets.zero,
        onTap: () => launchPage(
            context, UserPage(id: widget.profileData.id, setPage: (a) {})),
        backgroundImage: widget.profileData.images.isEmpty
            ? null
            : NetworkImage(widget.profileData.images.first.url),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: ThemeService.allAroundBorderRadius,
            gradient: widget.profileData.images.isEmpty
                ? null
                : LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Colors.white70, Colors.transparent]),
          ),
          height: 170,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("@${widget.profileData.username}",
                          style: TextStyle(color: ThemeService.primaryText)),
                      Text(
                        "${widget.profileData.firstName} ${widget.profileData.lastName}",
                        style: TextStyle(fontSize: 20),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  )),
                  if (widget.selectable || widget.dissmisable)
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                          foregroundColor: ThemeService.eventColor,
                          padding: const EdgeInsets.all(10),
                          shape: CircleBorder()),
                      child: Icon(
                          widget.selectable ? LineIcons.plus : LineIcons.minus),
                      onPressed: widget.onSelect == null
                          ? null
                          : () => widget.onSelect!(widget.profileData),
                    ),
                ],
              ),
            ],
          ),
        ));
  }
}
