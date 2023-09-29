import 'package:duration/duration.dart';
import 'package:duration/locale.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:table_calendar/table_calendar.dart';

class EventTime extends StatelessWidget {
  EventTime({Key? key, required this.date, required this.duration})
      : super(key: key);
  final DateTime date;
  late final Duration duration;

  String _durationToString() {
    return printDuration(duration,
        delimiter: ',', conjugation: ' ve ', locale: TurkishDurationLocale());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.timer, size: 40),
              const SizedBox(width: 10),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: LanguageService().data.sharable.date + " ",
                        style: TextStyle(color: ThemeService.secondaryText, fontSize: 12)),
                    TextSpan(
                        text: dateTimeToStr(date),
                        style: TextStyle(

                            fontFamily: ThemeService.headlineFont,
                            fontSize: 18))
                  ])),
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: LanguageService().data.sharable.duration + " ",
                        style: TextStyle(color: ThemeService.secondaryText, fontSize: 12)),
                    TextSpan(
                        text: _durationToString(),
                        style: TextStyle(

                            fontFamily: ThemeService.headlineFont,
                            fontSize: 18))
                  ])),
                ],
              ))
            ],
          ),
        ),
        AbsorbPointer(
          child: TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: date,
            rangeStartDay: date,
            rangeEndDay: date.add(duration),
            headerVisible: false,
            pageJumpingEnabled: false,
            locale: 'tr_TR',
            calendarStyle: CalendarStyle(
              rangeHighlightColor:
                  ThemeService.eventColor.withOpacity(0.7),
              todayDecoration: BoxDecoration(
                  color: ThemeService.disabledColor, shape: BoxShape.circle),
              rangeStartDecoration: BoxDecoration(
                  color: ThemeService.eventColor, shape: BoxShape.circle),
              rangeEndDecoration: BoxDecoration(
                  color: ThemeService.eventColor, shape: BoxShape.circle),
            ),
          ),
        )
      ],
    );
  }
}
