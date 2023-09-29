import 'package:date_picker_timeline/date_picker_widget.dart' as date_picker;
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/discover/discover.dart';
import 'package:ToGather/utilities/utilities.dart';

class FiltersModal extends StatefulWidget {
  const FiltersModal(
      {Key? key, required this.controller, required this.getItems})
      : super(key: key);
  final DiscoverFilterController controller;
  final Future<bool> Function() getItems;

  @override
  State<FiltersModal> createState() => _FiltersModalState();
}

class _FiltersModalState extends State<FiltersModal> {
  final _dateController = date_picker.DatePickerController();
  final _tagsController = EditableTagsController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dateController.animateToDate(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          left: 15,
          right: 15,
          top: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 15),
      //margin: const EdgeInsets.all(15),
      child: ListView(
        shrinkWrap: true,
        children: [
          FiltersSection(
              title: "Etiketler",
              child: EdittableTags(
                  controller: _tagsController,
                  onChanged: (tags) {
                    widget.controller.tags = tags;
                  },
                  showTitle: false)),
          FiltersSection(
              title: "Harita",
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FilterTogglable(
                      controller: FilterTogglableController(
                          toggled: widget.controller.showPosts),
                      title: "Gönderiler",
                      color: ThemeService.postColor,
                      onChanged: (value) {
                        widget.controller.showPosts = value;
                      },
                      icon: Icons.post_add),
                  FilterTogglable(
                      controller: FilterTogglableController(
                          toggled: widget.controller.showEvents),
                      title: "Etkinlikler",
                      color: ThemeService.eventColor,
                      onChanged: (value) {
                        widget.controller.showEvents = value;
                      },
                      icon: LineIcons.calendar),
                  FilterTogglable(
                      controller: FilterTogglableController(
                          toggled: widget.controller.showClubs),
                      title: "Topluluklar",
                      color: ThemeService.clubColor,
                      onChanged: (value) {
                        widget.controller.showClubs = value;
                      },
                      icon: LineIcons.users),
                  FilterTogglable(
                      controller: FilterTogglableController(
                          toggled: widget.controller.showPlaces),
                      title: "Mekanlar",
                      color: ThemeService.placeColor,
                      onChanged: (value) {
                        widget.controller.showPlaces = value;
                      },
                      icon: LineIcons.store),
                  FilterTogglable(
                      controller: FilterTogglableController(
                          toggled: widget.controller.showUsers),
                      title: "Arkadaşlar",
                      color: ThemeService.friendColor,
                      onChanged: (value) {
                        widget.controller.showUsers = value;
                      },
                      icon: LineIcons.user),
                ],
              )),
          FiltersSection(
              title: "Tarih",
              child: date_picker.DatePicker(
                DateTime.now().subtract(Duration(days: 7)),
                controller: _dateController,
                height: 100,
                initialSelectedDate: widget.controller.selectedDate,
                selectionColor: ThemeService.eventColor,
                selectedTextColor: ThemeService.onContrastColor,
                dateTextStyle: TextStyle(color: ThemeService.secondaryText),
                monthTextStyle: TextStyle(color: ThemeService.secondaryText),
                dayTextStyle: TextStyle(color: ThemeService.secondaryText),
                deactivatedColor: ThemeService.disabledColor,
                locale: "tr_TR",
                onDateChange: (date) {
                  widget.controller.selectedDate = date;
                },
              )),
        ],
      ),
    );
  }
}

class FiltersSection extends StatelessWidget {
  const FiltersSection({super.key, required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontFamily: ThemeService.headlineFont, fontSize: 20)),
          Divider(),
          child
        ],
      ),
    );
  }
}

class FilterTogglableController {
  bool toggled;

  FilterTogglableController({this.toggled = true});

  void toggle() {
    toggled = !toggled;
  }
}

class FilterTogglable extends StatefulWidget {
  const FilterTogglable(
      {super.key,
      required this.controller,
      required this.title,
      required this.icon,
      required this.color,
      required this.onChanged});
  final FilterTogglableController controller;
  final String title;
  final Color color;
  final IconData icon;
  final void Function(bool value) onChanged;

  @override
  State<FilterTogglable> createState() => _FilterTogglableState();
}

class _FilterTogglableState extends State<FilterTogglable> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            widget.controller.toggle();
          });
          widget.onChanged(widget.controller.toggled);
        },
        child: Column(
          children: [
            SylvestCard(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                margin: EdgeInsets.zero,
                borderRadius: BorderRadius.circular(100),
                background: widget.controller.toggled ? widget.color : null,
                child: Icon(
                  widget.icon,
                  size: 40,
                  color: widget.controller.toggled
                      ? ThemeService.onContrastColor
                      : ThemeService.disabledColor,
                )),
            Text(widget.title,
                style: TextStyle(
                    color: widget.controller.toggled
                        ? ThemeService.primaryText
                        : ThemeService.secondaryText))
          ],
        ));
  }
}
