import 'package:ToGather/events/widgets/components/componets.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/events/events.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class EventPage extends StatefulWidget {
  EventPage({required this.id});
  final int id;

  @override
  State<EventPage> createState() => EventPageState();
}

class EventPageState extends State<EventPage> {
  Event? _event;

  final _postManager = ModelServiceFactory.POST;

  Future<List<Widget>?> _onRefresh() async {
    _postManager.reset();
    _event = await ModelServiceFactory.EVENT
        .getItem(itemParameters: ItemParameters(id: widget.id));
    if (_event == null) {
      closePage(context);
      return null;
    }

    setState(() {});

    final posts = await _postManager.getList(queryParameters: PostQueryParameters(
      event: _event
    )) ?? [];
    final qrData = await ModelServiceFactory.EVENT
        .getQRData(itemParameters: ItemParameters(id: _event!.id));

    return [
      EventWidget(event: _event!),
      const SizedBox(height: 10),
      if (qrData != null) QRWidget(data: qrData),
      if (_event!.requestData.allowedActions.canForm)
        ResponsesButton(event: _event!),
      ...posts.map((e) => PostWidget(
            data: e,
            isDetail: false,
            onCommentSelected: (commendId, author) {},
          ))
    ];
  }

  Future<List<Widget>?> _onLoad() async {
    if (!_postManager.next()) return null;

    final posts = await _postManager.getList(
            queryParameters: PostQueryParameters(event: _event)) ??
        [];

    return posts
        .map((e) => PostWidget(
              data: e,
              isDetail: false,
              onCommentSelected: (commendId, author) {},
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        top: false,
        bottom: false,
        child: Scaffold(
          appBar: AppBar(
            actions: [
              if (_event != null)
                AllowedActionsWidget<EventAllowedActions, Event>(
                    model: _event!,
                    modelService: ModelServiceFactory.EVENT,
                    actions: _event!.requestData.allowedActions)
            ],
          ),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              RefreshablePage(
                onRefresh: _onRefresh,
                onLoad: _onLoad,
              ),
              if (_event != null &&
                  _event!.requestData.allowedActions.canAttend)
                AttendButton(event: _event!)
            ],
          ),
        ));
  }
}
