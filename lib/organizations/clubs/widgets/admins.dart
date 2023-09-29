import 'package:ToGather/organizations/clubs/clubs.dart';
import 'package:ToGather/organizations/places/models/place.dart';
import 'package:ToGather/users/filters/query_params.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/widgets.dart';
import 'package:ToGather/organizations/models/organization.dart';
import 'package:ToGather/users/users.dart';
import 'package:ToGather/utilities/utilities.dart';

class OrganizationAdmins extends StatefulWidget {
  const OrganizationAdmins({super.key, required this.organization});
  final Organization organization;

  @override
  State<OrganizationAdmins> createState() => _OrganizationAdminsState();
}

class _OrganizationAdminsState extends State<OrganizationAdmins> {
  final _profileManager = ModelServiceFactory.PROFILE;

  List<Profile> _admins = [];
  int _adminCount = 0;
  bool _isLoading = false;

  Future<void> _getMembers() async {
    setState(() {
      _isLoading = true;
    });

    _admins = (await _profileManager.getList(
          queryParameters: ProfileQueryParameters(
            clubAdmins: widget.organization is Club
                ? widget.organization as Club
                : null,
            placeAdmins: widget.organization is Place
                ? widget.organization as Place
                : null,
          ),
        )) ??
        [];
    _adminCount = (await _profileManager.getListCount(
          queryParameters: ProfileQueryParameters(
            clubAdmins: widget.organization is Club
                ? widget.organization as Club
                : null,
            placeAdmins: widget.organization is Place
                ? widget.organization as Place
                : null,
          ),
        )) ??
        0;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getMembers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
              text: TextSpan(
                  style: TextStyle(
                      color: ThemeService.secondaryText, fontSize: 17),
                  children: [
                TextSpan(text: "Yöneticiler"),
                TextSpan(text: " - "),
                TextSpan(text: "$_adminCount Kişi")
              ])),
          const SizedBox(height: 15),
          if (_isLoading)
            LoadingIndicator()
          else
            CarouselSlider.builder(
                itemCount: _admins.length,
                itemBuilder: (context, itemIndex, pageIndex) => Column(
                      children: [
                        SylvestImageProvider(
                            image: _admins[itemIndex].profileImage,
                            radius: 29,
                            defaultImage: /*DefaultImageManager.user*/ null),
                        Text(_admins[itemIndex].username)
                      ],
                    ),
                options: CarouselOptions(
                    enableInfiniteScroll: false,
                    pageSnapping: false,
                    viewportFraction: 0.2,
                    aspectRatio: 5,
                    padEnds: false))
        ],
      ),
    );
  }
}
