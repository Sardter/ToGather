import 'package:flutter/material.dart';
import 'package:ToGather/utilities/utilities.dart';

class SelectedGender extends StatefulWidget {
  const SelectedGender({super.key, required this.gender});
  final ValueNotifier<String?> gender;

  @override
  State<SelectedGender> createState() => _SelectedGenderState();
}

class _SelectedGenderState extends State<SelectedGender> {
  late bool _other = widget.gender.value != null &&
      widget.gender.value != "M" &&
      widget.gender.value != "F";

  final _options = <GenderData>[
    GenderData(title: "Erkek", icon: Icons.male, value: "M"),
    GenderData(title: "Kadın", icon: Icons.female, value: "F"),
    GenderData(
      title: "Diğer",
      icon: Icons.more,
    )
  ];

  late final _textController = TextEditingController(text: widget.gender.value);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
        valueListenable: widget.gender,
        builder: (context, value, child) => Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _options
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              if (value == e.value) {
                                widget.gender.value = null;
                                _other = false;
                              } else {
                                widget.gender.value = e.value;
                                _other = e.value == null;
                              }

                              if (_other) {
                                _textController.clear();
                              }
                              setState(() {});
                            },
                            child: GenderOption(
                                data: e,
                                selected: (e.value == value && value != null) ||
                                    (e.value == null && _other)),
                          ),
                        )
                        .toList(),
                  ),
                  if (_other) ...[
                    const SizedBox(height: 5),
                    RoundedTextField(
                        type: TextInputType.text,
                        controller: _textController,
                        onChanged: (value) => widget.gender.value = value,
                        hint: "Diğer")
                  ],
                ],
              ),
            ));
  }
}

class GenderData {
  final String title;
  final IconData icon;
  final String? value;

  const GenderData({required this.title, required this.icon, this.value});
}

class GenderOption extends StatelessWidget {
  const GenderOption({super.key, required this.data, this.selected = false});
  final GenderData data;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: selected
              ? ThemeService.eventColor
              : ThemeService.menuBackground,
          shape: BoxShape.circle),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [Icon(data.icon), Text(data.title)],
      ),
    );
  }
}
