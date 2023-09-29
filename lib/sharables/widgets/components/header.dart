import 'package:ToGather/sharables/sharables.dart';
import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class SharableHeader extends StatelessWidget {
  const SharableHeader({Key? key, required this.data}) : super(key: key);
  final Sharable data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0, bottom: 3),
      child: Row(
        children: <Widget>[
          Expanded(
            child: GestureDetector(
                onTap: () {
                  switch (data.author.runtimeType) {
                    case PostUserAuthor:
                      break;
                    case PostClubAuthor:
                      break;
                    case PostAnonymousAuthor:
                      break;
                  }
                },
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(children: <Widget>[
                    SylvestImageProvider(
                      radius: 20.0,
                      image: data.author.image,
                      defaultImage: null,
                    ),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.author.title,
                          style: TextStyle(
                              fontFamily: ThemeService.headlineFont,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ]),
                )),
          ),
          if (data.requestData != null)
            AllowedActionsWidget<AllowedActions, Sharable>(
              actions: data.requestData!.allowedActions,
              model: data,
              modelService: data is Post
                  ? ModelServiceFactory.POST
                  : ModelServiceFactory.COMMENT as ModelService<Sharable>,
            )
        ],
      ),
    );
  }
}
