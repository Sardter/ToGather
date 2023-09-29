import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/sharables/sharables.dart';
import 'package:ToGather/utilities/utilities.dart';

class SharableButtons extends StatefulWidget {
  SharableButtons(
      {required this.sharable,
      required this.onCommentSelected,
      this.isDetail = false});
  final Sharable sharable;
  final bool isDetail;
  final void Function(int? commentId, String? commentAuthor) onCommentSelected;

  @override
  SharableButtonsState createState() => SharableButtonsState();
}

class SharableButtonsState extends State<SharableButtons> {
  late bool _rated = widget.sharable.requestData?.rateOfUser != null;
  late double _rateValue = widget.sharable.requestData?.rateOfUser ?? 0;

  Future<void> _rate() async {
    double? result = await rate(
        context: context,
        onRate: (score) async => widget.sharable is Post
            ? ModelServiceFactory.POST.rate(
                itemParameters: ItemParameters(id: widget.sharable.id),
                score: score)
            : ModelServiceFactory.COMMENT.rate(
                itemParameters: ItemParameters(id: widget.sharable.id),
                score: score),
        initialScore: _rateValue);
    if (result != null && result != 0) {
      _rated = true;
      _rateValue = result;
    } else {
      _rated = false;
      _rateValue = 0;
    }

    setState(() {});
  }

  void _onComment(context) {
    if (widget.sharable is Comment) {
      widget.onCommentSelected(
          widget.sharable.id, widget.sharable.author.title);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          IconButton(
              onPressed: _rate,
              icon: Icon(_rated ? Icons.favorite : Icons.favorite_border,
                  color: _rated
                      ? ThemeService.eventColor
                      : ThemeService.unusedColor)),
          SizedBox(
            child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: '${_rateValue}'),
                  TextSpan(text: '\nKalp', style: TextStyle(fontSize: 8))
                ]),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ThemeService.headlineFont,
                    color: _rated
                        ? ThemeService.eventColor
                        : ThemeService.unusedColor)),
          ),
          IconButton(
              onPressed: () => _onComment(context),
              icon: Icon(LineIcons.comment, color: ThemeService.unusedColor)),
          SizedBox(
            child: Text.rich(
                TextSpan(children: [
                  TextSpan(text: '${widget.sharable.commentCount}'),
                  TextSpan(text: '\nyorum', style: TextStyle(fontSize: 8))
                ]),
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontFamily: ThemeService.headlineFont,
                    color: ThemeService.unusedColor)),
          ),
          if (widget.sharable is Post)
            ShareButton(
                shareableId: widget.sharable.id,
                type: LinkType.Post,
                color: ThemeService.unusedColor),
          /* Expanded(
              child: Align(
            alignment: Alignment.centerRight,
            child: _likedBy(),
          )) */
        ],
      ),
    );
  }
}
