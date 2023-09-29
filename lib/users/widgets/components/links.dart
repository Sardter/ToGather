import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/utilities/services/theme.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkWidget extends StatelessWidget {
  const LinkWidget({Key? key, required this.link, this.icon, this.name})
      : assert(icon != null || name != null),
        super(key: key);
  final String link;
  final String? icon;
  final String? name;

  final Map<String, IconData> _icons = const {
    'instagram': LineIcons.instagram,
    'facebook': LineIcons.facebook,
    'email': LineIcons.mailBulk,
    'linkedin': LineIcons.linkedin,
    'snapchat': LineIcons.snapchat,
    'whatsapp': LineIcons.whatSApp,
  };

  final IconData _defaultIcon = LineIcons.link;

  Future<void> _launchLink() async {
    String _link = link;
    if (!link.contains("http")) {
      _link = "https://" + _link;
    }
    await launchUrl(Uri.parse(link));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _launchLink(),
      child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon != null ? _icons[icon] ?? _defaultIcon : _defaultIcon,
                size: 30,
              ),
              const SizedBox(width: 10),
              Text(
                name != null ? name! : icon!,
                style: TextStyle(color: ThemeService.secondaryText),
              )
            ],
          )),
    );
  }
}

class LinksWidget extends StatelessWidget {
  const LinksWidget({Key? key, required this.links})
      : assert(links.length <= 5 && links.length > 0),
        super(key: key);
  final List<LinkData> links;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: links.length,
      separatorBuilder: (context, index) => Divider(
        indent: MediaQuery.of(context).size.width * 0.2,
        endIndent: MediaQuery.of(context).size.width * 0.2,
      ),
      itemBuilder: (context, index) =>
          LinkWidget(link: links[index].url, icon: links[index].type),
    );
  }
}
