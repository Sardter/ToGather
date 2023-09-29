import 'package:flutter/material.dart';
import 'package:ToGather/category/category.dart';
import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationBanner extends StatelessWidget {
  const OrganizationBanner({
    super.key,
    required Organization data,
  }) : _data = data;

  final Organization _data;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SizedBox(height: 310),
        Positioned(
            //top: 0,
            child: ClipRRect(
          child: SylvestImage(
            image: _data.banner,
            defaultImage: /*DefaultImageManager.clubBanner*/ null,
            height: 200,
            width: MediaQuery.of(context).size.width,
            useDefault: true,
          ),
        )),
        Positioned(
          bottom: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrganizationImage(data: _data),
                const SizedBox(width: 20),
                Expanded(
                  child: SizedBox(
                    height: 200,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Row(
                          children: [
                            OrganizationTitle(club: _data),
                            const Spacer(),
                            if (_data.verified) Icon(Icons.verified)
                          ],
                        ),
                        SmallCategoryWidget(category: _data.category),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        /* Positioned(
            top: 0,
            right: 10,
            child: ClubMoreMenu(
                actions: _data.allowedActions,
                data: _data,
                refresh: () async {
                  final refreshed = (await widget.refresh());
                  if (mounted)
                    setState(() {
                      _data = refreshed!;
                    });
                })), */
      ],
    );
  }
}
