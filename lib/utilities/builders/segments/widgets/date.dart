import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:table_calendar/table_calendar.dart';

class CreateEventDateSegment extends StatefulWidget
    implements CreatePageSegment {
  const CreateEventDateSegment({super.key, required this.dateController});
  final BuilderDateController dateController;

  @override
  State<CreateEventDateSegment> createState() => _CreateEventDateSegmentState();

  @override
  IconData get icon => Icons.calendar_month;

  @override
  String get label => "Tarih";
}

class _CreateEventDateSegmentState extends State<CreateEventDateSegment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          availableGestures: AvailableGestures.horizontalSwipe,
          firstDay: DateTime.utc(2022, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: DateTime.now(),
          pageJumpingEnabled: false,
          locale: 'tr_TR',
          rangeStartDay: widget.dateController.startDateController.date,
          rangeEndDay: widget.dateController.endDateController.date,
          headerStyle: HeaderStyle(formatButtonVisible: false),
          onDaySelected: (selectedDay, focusedDay) {
            if (widget.dateController.startDateController.date == null ||
                selectedDay.isBefore(
                    widget.dateController.startDateController.date!)) {
              widget.dateController.startDateController.date = selectedDay;
            } else {
              widget.dateController.endDateController.date = selectedDay;
            }
            setState(() {});
          },
          calendarStyle: CalendarStyle(
            markersMaxCount: 1,
            rangeHighlightColor: ThemeService.eventColor.withOpacity(0.7),
            selectedDecoration: BoxDecoration(
                color: ThemeService.eventColor, shape: BoxShape.circle),
            todayDecoration: BoxDecoration(
                color: ThemeService.disabledColor, shape: BoxShape.circle),
            rangeStartDecoration: BoxDecoration(
                color: ThemeService.eventColor, shape: BoxShape.circle),
            rangeEndDecoration: BoxDecoration(
                color: ThemeService.eventColor, shape: BoxShape.circle),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              DatePicker(
                  onRefresh: () => setState(() {}),
                  firstDate: DateTime(2023),
                  data: widget.dateController.startDateController,
                  hint: "Başlangıç Tarihi"),
              const SizedBox(height: 15),
              DatePicker(
                  onRefresh: () => setState(() {}),
                  firstDate: DateTime(2023),
                  data: widget.dateController.endDateController,
                  hint: "Bitiş Tarihi")
            ],
          ),
        ),
      ],
    );
  }
}
