import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ToGather/users/models/models.dart';
import 'package:ToGather/utilities/utilities.dart';

class EditableLink {
  final int id;
  final IconData icon;
  final TextEditingController controller;
  final String type;

  String get text => controller.text;

  bool get isValid => LinkController.isUrlValid(text);

  String get onError => LanguageService().data.builderVerifier.linkNotValid;

  Map get data => {'type': type, 'url': text};

  EditableLink(
      {required this.icon,
      required this.controller,
      required this.id,
      required this.type});

  factory EditableLink.fromType(String type, int id, {String? url}) {
    switch (type) {
      case 'instagram':
        return EditableLink.instagram(id, url: url);
      case 'snapchat':
        return EditableLink.snapchat(id, url: url);
      case 'email':
        return EditableLink.email(id, url: url);
      case 'twitter':
        return EditableLink.twitter(id, url: url);
      case 'website':
        return EditableLink.website(id, url: url);
      case 'whatsapp':
        return EditableLink.whatsapp(id, url: url);
      default:
        throw UnimplementedError();
    }
  }

  factory EditableLink.instagram(int id, {String? url}) {
    return EditableLink(
        icon: LineIcons.instagram,
        controller: TextEditingController(text: url),
        id: id,
        type: 'instagram');
  }

  factory EditableLink.whatsapp(int id, {String? url}) {
    return EditableLink(
        icon: LineIcons.whatSApp,
        controller: TextEditingController(text: url),
        id: id,
        type: 'whatsapp');
  }

  factory EditableLink.snapchat(int id, {String? url}) {
    return EditableLink(
        icon: LineIcons.snapchat,
        controller: TextEditingController(text: url),
        id: id,
        type: 'snapchat');
  }

  factory EditableLink.email(int id, {String? url}) {
    return EditableLink(
        icon: Icons.email,
        controller: TextEditingController(text: url),
        id: id,
        type: 'email');
  }

  factory EditableLink.twitter(int id, {String? url}) {
    return EditableLink(
        icon: LineIcons.twitter,
        controller: TextEditingController(text: url),
        id: id,
        type: 'twitter');
  }

  factory EditableLink.website(int id, {String? url}) {
    return EditableLink(
        icon: LineIcons.link,
        controller: TextEditingController(text: url),
        id: id,
        type: 'website');
  }
}

class LinkBuilderController {
  final BuilderWarningsController warningsController;
  final List<EditableLink> links;

  List<LinkData> get linksData =>
      links.map((e) => LinkData(url: e.controller.text, type: e.type)).toList();

  LinkBuilderController(
      {required this.warningsController, required this.links});
}

class LinkBuilder extends StatefulWidget {
  final LinkBuilderController controller;

  LinkBuilder({Key? key, required this.controller}) : super(key: key);

  @override
  State<LinkBuilder> createState() => _LinkBuilderState();
}

class _LinkBuilderState extends State<LinkBuilder> {
  void _onAdd(String type) {
    widget.controller.links
        .add(EditableLink.fromType(type, widget.controller.links.length));
    setState(() {});
  }

  void _onDismissed(int index) {
    widget.controller.links.removeWhere((element) => element.id == index);
    setState(() {});
  }

  Widget _link(EditableLink link) {
    return Dismissible(
        onDismissed: (dir) => _onDismissed(link.id),
        key: UniqueKey(),
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(link.icon),
                  const SizedBox(width: 10),
                  Expanded(
                      child: RoundedTextField(
                          type: TextInputType.text,
                          controller: link.controller,
                          canClear: false,
                          hint: link.type)),
                  IconButton(
                      onPressed: () => _onDismissed(link.id),
                      icon: Icon(Icons.close))
                ],
              ),
            ],
          ),
        ));
  }

  Widget _addButton(IconData icon, String type) {
    return GestureDetector(
      onTap: () => _onAdd(type),
      child: Column(
        children: [
          Icon(icon),
          Text(type,
              style: TextStyle(color: ThemeService.secondaryText, fontSize: 12))
        ],
      ),
    );
  }

  Widget _noLinks() {
    return SizedBox(
      height: 70,
      child: Center(
          child: Text("Linkler",
              style: TextStyle(color: ThemeService.secondaryText))),
    );
  }

  List<Widget> _buttons() {
    return [
      _addButton(LineIcons.instagram, 'instagram'),
      _addButton(LineIcons.whatSApp, 'whatsapp'),
      _addButton(LineIcons.twitter, 'twitter'),
      _addButton(Icons.email, 'email'),
      _addButton(LineIcons.link, 'website'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...widget.controller.links.map((e) => _link(e)),
          if (widget.controller.links.isEmpty) _noLinks(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _buttons(),
          )
        ],
      ),
    );
  }
}
