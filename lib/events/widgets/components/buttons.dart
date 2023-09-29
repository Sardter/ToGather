import 'package:ToGather/events/events.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class EventButtons extends StatefulWidget {
  const EventButtons({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<EventButtons> createState() => _EventButtonsState();
}

class _EventButtonsState extends State<EventButtons> {
  late bool _isRated = widget.event.requestData.isRated;
  late double? _rate = widget.event.requestData.userRate;

  _onPost() async {
    await launchPage(
        context,
        CreatePostPage(
            controller: CreatePostController.newPost(ModelServiceFactory.POST,
                initialSelectedEvent: widget.event)));
  }

  _onRate() async {
    _rate = await rate(
        context: context,
        onRate: (score) => ModelServiceFactory.EVENT.rate(
            itemParameters: ItemParameters(id: widget.event.id), score: score),
        initialScore: _rate);

    _isRated = _rate != null && _rate != 0;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          SylvestIconButton(
              title: "${_rate ?? 0} kalp",
              icon: _isRated ? Icons.favorite : Icons.favorite_border,
              display: widget.event.requestData.allowedActions.canRate,
              color: _isRated ? ThemeService.eventColor : null,
              onTap: _onRate),
          SylvestIconButton(
              title: LanguageService().data.titles.post,
              icon: LineIcons.shareSquare,
              onTap: _onPost,
              display: widget.event.requestData.allowedActions.canPost),
          ShareButton(
              shareableId: widget.event.id,
              type: LinkType.Event,
              showTitle: true),
        ],
      ),
    );
  }
}
